//
//  MainTable.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct MainTable: View {

    @EnvironmentObject var context: AppContext


    var body: some View {
        List([context.model], children: \.children) {
            TableRow(row: $0)
        }
        .accentColor(.genivi)
        .navigationTitle("VSS GraphQL")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct MainTable_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
