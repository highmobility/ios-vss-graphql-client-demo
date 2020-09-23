//
//  SendButton.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 22.09.20.
//

import Alamofire
import AutoGraphQL
import SwiftUI


struct SendButton: View {

    @Binding var selectedDatapoints: Set<Datapoint>
    @EnvironmentObject var response: BatteryManagementResponse

    var isVisible: Bool {
        selectedDatapoints.count > 0
    }

    var body: some View {
        Button(action: {
            response.execute(selectedDatapoints: selectedDatapoints)
        }, label: {
            VStack {
                VStack {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Spacer(minLength: 3)
                    Text("SEND").font(.system(size: 6.0))
                }
                .padding(EdgeInsets(top: 9.0, leading: 7.0, bottom: 5.0, trailing: 7.0))
                .background(Color.gray.opacity(0.10))
                .cornerRadius(15)

                Spacer()
            }
        })
        .foregroundColor(Color("genivi"))
        .opacity(isVisible ? 1.0 : 0.0) // because "normally" hiding it ruins the layout
    }
}

struct SendButton_Previews: PreviewProvider {

    static var previews: some View {
        SendingView()
            .preferredColorScheme(.dark)
    }
}
