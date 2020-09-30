//
//  AppContext.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import Alamofire
import AutoGraphQL
import Combine
import Foundation


class AppContext: ObservableObject {

    @Published var error: Error? = nil
    @Published var urlStr: String = "http://localhost:4000/"


    let model = TableRowModel(keyPath: \BatteryManagement.self, name: "batteryManagement", children: [
        TableRowModel(keyPath: \BatteryManagement.accumulatedChargedEnergy, name: "accumulatedChargedEnergy"),
        TableRowModel(keyPath: \BatteryManagement.accumulatedConsumedEnergy, name: "accumulatedConsumedEnergy"),
        TableRowModel(keyPath: \BatteryManagement.batteryCapacity, name: "batteryCapacity"),
        TableRowModel(keyPath: \BatteryManagement.batteryTemperature, name: "batteryTemperature"),
        TableRowModel(keyPath: \BatteryManagement.chargingInlet, name: "chargingInlet"),
        TableRowModel(keyPath: \BatteryManagement.grossCapacity, name: "grossCapacity"),
        TableRowModel(keyPath: \BatteryManagement.lowBatteryLevel, name: "lowBatteryLevel"),
        TableRowModel(keyPath: \BatteryManagement.netCapacity, name: "netCapacity"),
        TableRowModel(keyPath: \BatteryManagement.nominalVoltage, name: "nominalVoltage"),
        TableRowModel(keyPath: \BatteryManagement.referentVoltage, name: "referentVoltage"),

        TableRowModel(keyPath: \BatteryManagement.stateOfCharge, name: "stateOfCharge", children: [
            TableRowModel(keyPath: \BatteryManagement.stateOfCharge?.current, name: "current"),
            TableRowModel(keyPath: \BatteryManagement.stateOfCharge?.displayed, name: "displayed"),
            TableRowModel(keyPath: \BatteryManagement.stateOfCharge?.target, name: "target"),
        ]),
    ])


    func sendRequest<T>(type: T.Type) where T: GraphQLType {
        // TODO: execute on a bg-thread
        guard let operation = graphQLOperation else {
            return
        }

        let client = AlamofireClient(baseUrl: urlStr, session: .default)
        let autoGraph = AutoGraph(client: client)
        let request = GraphQLRequest<T>(operation: operation)

        autoGraph.send(request) {
            switch $0 {
            case .failure(let error):
                self.error = error

            case .success(let result):
                self.error = nil
                self.model.update(result: result)
            }
        }
    }
}

private extension AppContext {

    var graphQLOperation: AutoGraphQL.Operation? {
        guard model.isSelected else {
            return nil
        }

        return AutoGraphQL.Operation(type: .query, name: "DemoQuery", selectionSet: [
            Object(name: "vehicle", selectionSet: [
                    Object(name: "drivetrain", selectionSet: [model.graphQLSelectionSet ?? nil].compactMap { $0 })
            ])
        ])
    }
}
