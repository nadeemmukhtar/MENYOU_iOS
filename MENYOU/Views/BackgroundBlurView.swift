//
//  BackgroundBlurView.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/17/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import UIKit
import SwiftUI

struct BackgroundBlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BackgroundBlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .homeBackgroundColor
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BackgroundBlurView>) {

    }
}
