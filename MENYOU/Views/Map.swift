//
//  Map.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/16/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import MapKit
import SwiftUI

struct Map: View {
    
    @Binding var position: CardPosition
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    var body: some View {
        
        ZStack {
            MapView(
                centerCoordinate: $centerCoordinate,
                annotations: locations
            )
                .overlay(position == .top ? Color.black.opacity(0.5) : Color.clear)
                .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.5).speed(1.5))
                .edgesIgnoringSafeArea(.all)
        }
    }
}
