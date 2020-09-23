//
//  SendingView.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 21.09.20.
//

import SwiftUI
import JSONValueRX


struct SendingView: View {

    @State var selectedDatapoints: Set<Datapoint> = Set<Datapoint>()
    @State var response = BatteryManagementResponse()
    @State private var showingAlert1 = false

    @State var urlString: String = "http://192.168.1.8:4000/graphql" {
        didSet {
            response.urlStr = urlString
        }
    }


    var body: some View {
        NavigationView {
            VStack {
                if showingAlert1 {
                    VStack(alignment: .leading) {
                        Text("Enter a new URL")
                            .font(Font.system(size: 12.0).weight(.light))

                        TextField("Enter a new URL...", text: self.$urlString, onCommit: {
                            withAnimation(.easeIn) {
                                showingAlert1 = false
                            }
                        })
                        .padding(.vertical, 7)
                    }
                    .padding()
                }
                else {
                    DatapointsList(selectedDatapoints: $selectedDatapoints)
                        .navigationBarTitle("VSS GraphQL")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Menu {
                                                Button("URL", action: {
                                                    withAnimation(.easeIn) {
                                                        showingAlert1 = true
                                                    }
                                                }) }
                                                label: {
                                                    VStack {
                                                        Image(systemName: "slider.horizontal.3")
                                                    }
                                                }
                                                .foregroundColor(Color("genivi")),
                                            trailing: SendButton(selectedDatapoints: $selectedDatapoints)
                        )
                        .environmentObject(response)
                }
            }
        }
    }
}

struct SenddingView_Preview: PreviewProvider {

    static var previews: some View {
        SendingView()
            .preferredColorScheme(.dark)
    }
}



struct DatapointsList: View {

    @Binding var selectedDatapoints: Set<Datapoint>

    let datapoints: [Datapoint] = [.batteryManagement]


    var body: some View {
        List(datapoints, children: \.children) {
            DatapointRow(selectedDatapoints: $selectedDatapoints, datapoint: $0)
        }
        .accentColor(Color("genivi"))
    }
}



struct DatapointRow: View {

    @Binding var selectedDatapoints: Set<Datapoint>
    @EnvironmentObject var response: BatteryManagementResponse

    let datapoint: Datapoint


    var body: some View {
        let isSelected = Binding<Bool>(
            get: { selectedDatapoints.contains(datapoint) },
            set: {
                if $0 {
                    selectedDatapoints.insert(datapoint)
                }
                else {
                    selectedDatapoints.remove(datapoint)
                }
            })


        let update = response[keyPath: datapoint.keyPath] as! Any?  // won't work without this 'as! Any?'

        return HStack {
            Text(datapoint.field.name)
                .font(.system(size: 12.0, design: .monospaced))
                .layoutPriority(1)

            if datapoint.children == nil {
                HStack() {
                    Spacer()

                    if let update = update {
                        let str = "\(update)"

                        Text(str)
                            .font(.system(size: 10.0))
                    }

                    Image(systemName: isSelected.wrappedValue ? "checkmark.circle" : "circle")
                        .foregroundColor(Color("genivi"))
                        .font(Font.body.weight(.medium))
                }
            }
        }
        .onTapGesture {
            isSelected.wrappedValue.toggle()
        }
    }
}
