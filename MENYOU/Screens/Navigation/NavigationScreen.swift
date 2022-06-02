//
//  NavigationScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/16/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct NavigationScreen: View {
    @ObservedObject var state: AppState
    
    var body: some View {
        HomeScreen(state: state)
    }
}
