//
//  ProfileScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 8/5/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct ProfileScreen: View {
    @ObservedObject var state: AppState
    var onClose: (() -> Void)? = nil
    @State var cardState = CGSize.zero
    let bottomPadding: CGFloat = 60
    
    var body: some View {
        VStack {
            //Spacer()
            
            VStack(spacing: 30) {
                Spacer().frame(height: 20)
                HStack() {
                    DownButton {
                        self.onClose?()
                    }
                    
                    Spacer()
                    
                    Text("Profile")
                    .modifier(TextModifier(size: 20, font: Font.sofiaProBold))
                    .foregroundColor(Color.blackColor)
                    .padding(.leading, 0)
                    
                    Spacer().frame(width: 20)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            //.padding(.bottom, bottomPadding)
            .frame(width: screenWidth, height: screenHeight)
            .background(
                BackgroundBlurView(style: .systemThinMaterialLight)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .cornerRadius(radius: isIPhoneX ? 30 : 18, corners: [.topLeft, .topRight]))
                .offset(y: self.cardState.height)
        }
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}
