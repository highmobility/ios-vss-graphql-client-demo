//
//  MainView.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct MainView: View {

    @EnvironmentObject var context: AppContext
    @State var isEditingURL: Bool = false


    var body: some View {
        let alertBinding = Binding<Bool>(get: { context.error != nil },
                                         set: { _ in context.error = nil })

        return GeometryReader { geometry in
            ZStack {
                NavigationView {
                    MainTable()
                        .navigationBarItems(leading: MenuButton(isEditingURL: $isEditingURL),
                                            trailing: SendButton())
                }
                .alert(isPresented: alertBinding, content: {
                    let text = "\(context.error!)"

                    return Alert(title: Text("Error"), message: Text(text))
                })

                if isEditingURL {
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.9)
                        .onTapGesture {
                            isEditingURL = false
                        }

                    URLChangingView(isEditingURL: $isEditingURL)
                        .alignmentGuide(VerticalAlignment.center) { _ in geometry.size.height / 3.0 }
                }
            }
        }
    }
}


struct MainView_Preview: PreviewProvider {

    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(AppContext())
    }
}
