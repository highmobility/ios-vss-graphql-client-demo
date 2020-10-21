//
//  AppContext.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import Combine
import Foundation
import VSSGraphQLClient


class AppContext: ObservableObject {

    @Published var error: Error? = nil
    @Published var urlStr: String = "http://localhost:4000/"

    let model: TableRowModel


    func sendRequest<T>(type: T.Type) where T: GraphQLType {
        guard let operation = graphQLOperation,
              let url = URL(string: urlStr) else {
            return
        }

        let request = VSSGraphQLRequest<T>(operation: operation, rootKeyPath: "data.vehicle")

        request.send(url: url) {
            switch $0 {
            case .failure(let error):
                print(error)
                self.error = error
                
            case .success(let result):
                self.error = nil
                self.model.update(result: result)
            }
        }
    }


    init() {
        model = Self.createTableRowModels(name: "vehicle", type: Vehicle.self)
    }
}

private extension AppContext {

    var graphQLOperation: VSSGraphQLOperation? {
        guard model.isSelected else {
            return nil
        }

        return VSSGraphQLOperation(type: .query, name: "DemoQuery", selectionSet:
            [model.graphQLSelectionSet ?? nil].compactMap { $0 }
        )
    }


    static func createTableRowModels(name: String, type: GraphQLObjectType.Type) -> TableRowModel {
        var children: [TableRowModel] = type.scalars.map { TableRowModel(name: $0.key) }

        children += type.objects.map {
            createTableRowModels(name: $0.key, type: $0.value)
        }

        return TableRowModel(name: name, children: children)
    }
}
