//
//  FavoriteScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/27/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct FavoriteScreen: View {
    @ObservedObject var state: AppState
    var onClose: (() -> Void)? = nil
    var onTap: ((Resturant) -> Void)? = nil
    @State var cardState = CGSize.zero
    let bottomPadding: CGFloat = 60
    
    @State private var contentOffset: CGPoint = CGPoint(x: screenWidth, y: 0)
    
    var body: some View {
        VStack {
            //Spacer()
            
            VStack(spacing: 30) {
                Spacer()
                HStack() {
                    DownButton {
                        self.onClose?()
                    }
                    
                    Spacer()
                    
                    Text("My Favorites")
                    .modifier(TextModifier(size: 20, font: Font.sofiaProBold))
                    .foregroundColor(Color.blackColor)
                    .padding(.leading, 0)
                    
                    Spacer().frame(width: 20)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                //Spacer()
                
                /*ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Favorite.items) { item in
                        FavoriteCell(favorite: item) { restaurant in
                            self.onTap?(restaurant)
                        }
                        Spacer().frame(height: 16)
                    }
                }*/
                ScrollableView($contentOffset, animationDuration: 0.5, action: { value in
                    if value >= 100 {
                        DispatchQueue.main.async {
                            self.onClose?()
                        }
                    }
                }) {
                    ForEach(Favorite.items) { item in
                        FavoriteCell(favorite: item) { restaurant in
                            self.onTap?(restaurant)
                        }
                        Spacer().frame(height: 16)
                    }
                }
                .frame(width: screenWidth)
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
            Spacer()
        }
        .padding(.top, 0)
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}
