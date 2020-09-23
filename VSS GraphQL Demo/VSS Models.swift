//
//  VSS Models.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 22.09.20.
//

import Alamofire
import AutoGraphQL
import Combine
import Foundation


enum ChargingInlet: String, Decodable {

    case unknown = "unknown"
    case NotFitted = "Not_Fitted"
    case ACType1 = "AC_Type_1"
    case ACType2 = "AC_Type_2"
    case ACGbt = "AC_GBT"
    case ACDcType1Combo = "AC_DC_Type_1_Combo"
    case ACDcType2Combo = "AC_DC_Type_2_Combo"
    case DCGbt = "DC_GBT"
    case DCChademo = "DC_Chademo"
}

struct StateOfCharge: Decodable, Equatable {

    let current: Float?
    let displayed: Float?
    let target: Int?
}

struct BatteryManagement: Decodable, Equatable {

    let batteryCapacity: Int?
    let batteryTemperature: Float?
    let chargingInlet: ChargingInlet?
    let lowBatteryLevel: Bool?
    let grossCapacity: Int?
    let netCapacity: Int?
    let nominalVoltage: Int?
    let referentVoltage: Int?
    let accumulatedChargedEnergy: Float?
    let accumulatedConsumedEnergy: Float?
    let stateOfCharge: StateOfCharge?
}


// TODO: change to UI MODEL (different rows and their states)
class BatteryManagementResponse: ObservableObject {

    @Published var batteryManagement: BatteryManagement?
    @Published var urlStr: String = "http://192.168.1.8:4000/graphql"


    func execute(selectedDatapoints: Set<Datapoint>) {
        let req = BatteryManagementRequest(selectedDatapoints: selectedDatapoints)
        let ag = AutoGraph(client: AlamofireClient(baseUrl: urlStr, session: Session.default))

        ag.send(req) {
            switch $0 {
            case .failure(let error):
                print("ERROR")
                print(error)

                self.batteryManagement = nil

            case .success(let batteryManagement):
                self.batteryManagement = batteryManagement
            }
        }
    }
}
