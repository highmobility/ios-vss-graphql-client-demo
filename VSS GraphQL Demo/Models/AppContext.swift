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


    let model = TableRowModel(name: "vehicle", children: [
        TableRowModel(name: "cabin", children: [
            TableRowModel(name: "infotainment", children: [
                TableRowModel(name: "navigation", children: [
                    TableRowModel(name: "currentLocation", children: [
                        TableRowModel(name: "longitude"),
                        TableRowModel(name: "latitude"),
                        TableRowModel(name: "altitude")
                    ])
                ])
            ])
        ]),

        TableRowModel(name: "drivetrain", children: [
            TableRowModel(name: "transmission", children: [
                TableRowModel(name: "speed")
            ]),

            TableRowModel(name: "fuelSystem", children: [
                TableRowModel(name: "level")
            ])
        ]),

        TableRowModel(name: "acceleration", children: [
            TableRowModel(name: "longitudinal"),
            TableRowModel(name: "lateral"),
            TableRowModel(name: "vertical")
        ]),

        TableRowModel(name: "adas", children: [
            TableRowModel(name: "abs", children: [
                TableRowModel(name: "isEngaged")
            ])
        ]),

        TableRowModel(name: "obd", children: [
            TableRowModel(name: "coolantTemperature")
        ]),

        TableRowModel(name: "travelledDistance")
    ])


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
}
