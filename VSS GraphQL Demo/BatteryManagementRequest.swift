//
//  BatteryManagementRequest.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 22.09.20.
//

import AutoGraphQL
import Foundation
import JSONValueRX


class BatteryManagementRequest: AutoGraphQL.Request {

    static let fieldName = "batteryManagement"

    let operation: AutoGraphQL.Operation


    init(selectedDatapoints: Set<Datapoint>) {
        var subFields: [FieldRepresenting] = selectedDatapoints.filter {
            $0.field.parentName == Self.fieldName
        }.map {
            Scalar(name: $0.field.name)
        }


        let socScalars = selectedDatapoints.filter {
            $0.field.parentName == "stateOfCharge"
        }.map {
            Scalar(name: $0.field.name)
        }

        if !socScalars.isEmpty {
            subFields.append(Object(name: "stateOfCharge", selectionSet: socScalars))
        }


        operation = Operation(type: .query,
                              name: "BatteryManagementQuery",
                              selectionSet: [
                                Object(name: "vehicle", selectionSet: [
                                    Object(name: "drivetrain", selectionSet: [
                                        Object(name: Self.fieldName, selectionSet: subFields)
                                    ])
                                ])
                              ])
    }


    // MARK: Request

    var queryDocument: AutoGraphQL.Operation { operation }
    let rootKeyPath: String = "data.vehicle.drivetrain.batteryManagement"
    let variables: [AnyHashable : Any]? = nil

    public func willSend() throws { }
    public func didFinishRequest(response: HTTPURLResponse?, json: JSONValue) throws { }
    public func didFinish(result: Result<BatteryManagement, Error>) throws { }
}
