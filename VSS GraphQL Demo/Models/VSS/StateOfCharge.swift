//
//  StateOfCharge.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 23.09.20.
//

import Foundation


struct StateOfCharge: GraphQLType {
    
    var current: Float? = nil
    var displayed: Float? = nil
    var target: Int? = nil


    // MARK: GraphQLType

    static let rootKeyPath = "data.vehicle.drivetrain.batteryManagement.stateOfCharge"
}
