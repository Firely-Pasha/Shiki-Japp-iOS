//
//  VisualEffectView.swift
//  shikijappios
//
//  Created by Pavel on 26.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
