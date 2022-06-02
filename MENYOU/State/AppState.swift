//
//  AppState.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/15/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI
import Combine

final class AppState: ObservableObject {
    
    @Published var showRestaurants = true
    @Published var showProfile = false
    @Published var showFavorites = false
    @Published var showFood = false
    @Published var showDetail = false
}
