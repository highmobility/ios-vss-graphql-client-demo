//
//  ChargingInlet.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 23.09.20.
//

import Foundation


enum ChargingInlet: String, GraphQLType {
    
    case unknown = "unknown"
    case NotFitted = "Not_Fitted"
    case ACType1 = "AC_Type_1"
    case ACType2 = "AC_Type_2"
    case ACGbt = "AC_GBT"
    case ACDcType1Combo = "AC_DC_Type_1_Combo"
    case ACDcType2Combo = "AC_DC_Type_2_Combo"
    case DCGbt = "DC_GBT"
    case DCChademo = "DC_Chademo"


    // MARK: GraphQLType

    static let rootKeyPath = "data.vehicle.drivetrain.batteryManagement.chargingInlet"
}
