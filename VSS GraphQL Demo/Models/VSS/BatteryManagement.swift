//
//  BatteryManagement.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 23.09.20.
//

import Foundation


struct BatteryManagement: GraphQLType {

    var batteryCapacity: Int? = nil
    var batteryTemperature: Float? = nil
    var chargingInlet: ChargingInlet? = nil
    var lowBatteryLevel: Bool? = nil
    var grossCapacity: Int? = nil
    var netCapacity: Int? = nil
    var nominalVoltage: Int? = nil
    var referentVoltage: Int? = nil
    var accumulatedChargedEnergy: Float? = nil
    var accumulatedConsumedEnergy: Float? = nil
    var stateOfCharge: StateOfCharge? = nil


    // MARK: GraphQLType

    static let rootKeyPath = "data.vehicle.drivetrain.batteryManagement"
}
