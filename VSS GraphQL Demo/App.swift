//
//  hm_vss_client_demoApp.swift
//  hm-vss-client-demo
//
//  Created by Mikk Rätsep on 21.09.20.
//

import SwiftUI
import AutoGraphQL
import Alamofire


@main struct hm_vss_client_demoApp: App {

    var body: some Scene {
        WindowGroup {
            SendingView()
        }
    }
}
