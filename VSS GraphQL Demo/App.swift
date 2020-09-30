//
//  VSSGraphQLDemoApp.swift
//  hm-vss-client-demo
//
//  Created by Mikk Rätsep on 21.09.20.
//

import SwiftUI


@main struct VSSGraphQLDemoApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppContext())
        }
    }
}
