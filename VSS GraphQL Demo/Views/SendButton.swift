//
//  SendButton.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct SendButton: View {

    @EnvironmentObject var context: AppContext


    var body: some View {
        let isLoaded = context.model.isLoaded

        return Group {
            if context.model.isSelected || context.model.isLoaded {
                Button(action: {
                    if isLoaded {
                        context.model.resetToDeselected()
                        context.objectWillChange.send()
                    }
                    else {
                        context.sendRequest(type: BatteryManagement.self)
                    }
                }, label: {
                    VStack {
                        Image(systemName: isLoaded ? "arrow.triangle.2.circlepath" : "dot.radiowaves.left.and.right")

                        Spacer(minLength: 3)

                        Text(isLoaded ? "clear" : "send")
                            .font(Font.system(size: 8.0).smallCaps())
                    }
                })
            }
        }
        .foregroundColor(.genivi)
    }
}


struct SendButton_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
