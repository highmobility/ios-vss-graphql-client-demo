//
//  URLChangingView.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI

struct URLChangingView: View {

    @Binding var isEditingURL: Bool
    @EnvironmentObject var context: AppContext


    var body: some View {
        let urlBinding = Binding<String>(get: { context.urlStr },
                                         set: { context.urlStr = $0 })

        return Group {
            if isEditingURL {
                VStack(alignment: .leading) {
                    Text("Enter a new URL")
                        .font(Font.system(size: 12.0).weight(.light))

                    Text("Note: some GraphQL endpoints end with \"/graphql\", while others need a port, i.e. \":4000\".")
                        .font(Font.system(size: 6.0, weight: .ultraLight))

                    TextField("Enter a new URL...", text: urlBinding, onCommit: { isEditingURL = false })
                        .padding(.vertical, 7)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color.black.opacity(0.75))
                )
                .padding()
            }
        }
    }
}


struct URLChangingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
