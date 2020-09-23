//
//  Datapoint.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 21.09.20.
//

import Foundation
import AutoGraphQL
import JSONValueRX


struct Datapoint: Equatable, Hashable, Identifiable {

    let field: FieldInfo
    let keyPath: PartialKeyPath<BatteryManagementResponse>
    var children: [Datapoint]? = nil


    // MARK: Equatable

    static func ==(lhs: Datapoint, rhs: Datapoint) -> Bool {
        lhs.id == rhs.id
    }


    // MARK: Hashable

    var hashValue: Int {
        id.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }


    // MARK: Identifiable

    let id = UUID()
}

extension Datapoint {

    static var batteryManagement: Datapoint {
        Datapoint(field: FieldInfo(name: "batteryManagement",
                                   parentName: "drivetrain"),
                  keyPath: \BatteryManagementResponse.batteryManagement,
                  children: [
                    Datapoint(field: FieldInfo(name: "batteryCapacity", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.batteryCapacity),
                    Datapoint(field: FieldInfo(name: "batteryTemperature", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.batteryTemperature),
                    Datapoint(field: FieldInfo(name: "chargingInlet", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.chargingInlet),
                    Datapoint(field: FieldInfo(name: "lowBatteryLevel", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.lowBatteryLevel),
                    Datapoint(field: FieldInfo(name: "grossCapacity", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.grossCapacity),
                    Datapoint(field: FieldInfo(name: "netCapacity", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.netCapacity),
                    Datapoint(field: FieldInfo(name: "nominalVoltage", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.nominalVoltage),
                    Datapoint(field: FieldInfo(name: "referentVoltage", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.referentVoltage),
                    Datapoint(field: FieldInfo(name: "accumulatedChargedEnergy", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.accumulatedChargedEnergy),
                    Datapoint(field: FieldInfo(name: "accumulatedConsumedEnergy", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.accumulatedConsumedEnergy),

                    Datapoint(field: FieldInfo(name: "stateOfCharge", parentName: "batteryManagement"),
                              keyPath: \BatteryManagementResponse.batteryManagement?.stateOfCharge,
                              children: [
                                Datapoint(field: FieldInfo(name: "current", parentName: "stateOfCharge"),
                                          keyPath: \BatteryManagementResponse.batteryManagement?.stateOfCharge?.current),
                                Datapoint(field: FieldInfo(name: "displayed", parentName: "stateOfCharge"),
                                          keyPath: \BatteryManagementResponse.batteryManagement?.stateOfCharge?.displayed),
                                Datapoint(field: FieldInfo(name: "target", parentName: "stateOfCharge"),
                                          keyPath: \BatteryManagementResponse.batteryManagement?.stateOfCharge?.target)
                              ])
        ])
    }
}


struct FieldInfo {
    let name: String
    let parentName: String
}
