//
//  DetailScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/30/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct DetailScreen: View {
    var restaurant: Resturant
    var food: Food
    var onClose: (() -> Void)? = nil
    
    @State var cardState = CGSize.zero
    let bottomPadding: CGFloat = 60
    let options: [String] = ["For You", "Entrees", "Sweets"]
    @State var isFeaturedAllowed = true
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                HStack() {
                    DownButton {
                        self.onClose?()
                    }
                    
                    Spacer()
                    
                    Text(restaurant.title)
                    .modifier(TextModifier(size: 20, font: Font.sofiaProBold))
                    .foregroundColor(Color.blackColor)
                    .padding(.leading, 0)
                    
                    Spacer().frame(width: 20)
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                ZStack {
                    Image(food.image)
                    .renderingMode(.original)
                    .resizable()
                    //.aspectRatio(contentMode: .fill)
                    .frame(height: 438)
                    .cornerRadius(30)
                    .contentShape(Rectangle())
                    
                    VStack {
                        Spacer()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("AR MODE")
                                .modifier(TextModifier(size: 14, font: Font.sofiaProBoldCondensed, color: Color.white))
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Button(action: {
                                        impact(style: .soft)
                                        self.isFeaturedAllowed.toggle()
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 50, height: 22)
                                                .foregroundColor(Color.white.opacity(0.8))
                                                .animation(.easeInOut(duration: 0.3))
                                                .cornerRadius(20)
                                            
                                            Circle()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.whiteColor)
                                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                                .offset(x: self.isFeaturedAllowed ? 12 : -12)
                                                .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0))
                                            
                                            Circle()
                                            .frame(width: 22, height: 22)
                                            .foregroundColor(self.isFeaturedAllowed ? Color.pinkColor : Color.whiteColor)
                                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                            .offset(x: self.isFeaturedAllowed ? 12 : -12)
                                            .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0))
                                        }
                                    }
                                    .buttonStyle(ButtonBounce())
                                    
                                    Spacer()
                                    FavoriteeButton {}
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    .padding(.bottom, 20)
                }
                .frame(height: 438)
                .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners])).shadow(color: .shadowColor, radius: 30)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(food.title)
                    .modifier(TextModifier(size: 32, font: Font.sofiaProBold, color: Color.blackColor))
                    Spacer().frame(height: 10)
                    Text(food.detail)
                    .modifier(TextModifier(size: 16, font: Font.sofiaProRegular, color: Color.primaryTextColor))
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 50)
                Spacer().frame(height: 0)
                
                ZStack {
                    HStack {
                        Text("$" + food.price)
                            .modifier(TextModifier(size: 26, font: Font.sofiaProBold, color: Color.white))
                            .padding(.leading, 30)
                        Spacer()
                        AddButton {}
                        .padding(.trailing, 20)
                    }
                }
                .frame(height: 123)
                .background(Color.black.cornerRadius(radius: 20, corners: [.topLeft, .topRight])).shadow(color: .shadowColor, radius: 30)
                .padding(.horizontal, -20)
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            .frame(width: screenWidth, height: screenHeight)
            .background(
                BackgroundBlurView(style: .systemThinMaterialLight)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .cornerRadius(radius: isIPhoneX ? 30 : 18, corners: [.topLeft, .topRight]))
                .offset(y: self.cardState.height)
        }
        .padding(.top, 0)
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(restaurant: Resturant.items[0], food: Food.items[0])
    }
}
