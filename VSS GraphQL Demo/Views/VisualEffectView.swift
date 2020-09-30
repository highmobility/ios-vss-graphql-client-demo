//
//  VisualEffectView.swift
//  VSS GraphQL Demo
//
//  Created by Mikk Rätsep on 30.09.20.
//

import SwiftUI


struct VisualEffectView: UIViewRepresentable {

    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
