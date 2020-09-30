//
//  MenuButton.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct MenuButton: View {

    @Binding var isEditingURL: Bool
    @EnvironmentObject var context: AppContext


    var body: some View {
        Menu(content: {
            Button(action: {
                isEditingURL = true
            }, label: {
                Text("Change URL")
            })
        }, label: {
            Image(systemName: "slider.horizontal.3")
        })
        .foregroundColor(.genivi)
    }
}


struct MenuView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
