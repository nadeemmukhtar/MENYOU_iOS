//
//  FoodScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/29/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct FoodScreen: View {
    @ObservedObject var state: AppState
    var restaurant: Resturant
    var onClose: (() -> Void)? = nil
    var onTap: ((Food) -> Void)? = nil
    
    @State var cardState = CGSize.zero
    let bottomPadding: CGFloat = 60
    let options: [String] = ["For You", "Entrees", "Sweets"]
    @State private var cType: String = "For You"
    
    @State private var contentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
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
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                /*ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        ZStack {
                            Image(restaurant.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 218)
                            .cornerRadius(30)
                            .contentShape(Rectangle())
                            
                            VStack {
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(restaurant.title)
                                        .modifier(TextModifier(size: 24, font: Font.sofiaProBold, color: Color.whiteColor))
                                        .padding(.bottom, 20)
                                        
                                        HStack {
                                            ForEach(0..<3) { index in
                                                Text(index == 0 ? "1.0mi" : (index == 1 ? self.restaurant.type : "$$"))
                                                    .modifier(TextModifier(size: 16, font: Font.sofiaProRegular, color: Color.white))
                                                    .padding(.horizontal, 14)
                                                    .padding(.vertical, 6)
                                                .background(Color.cellColor.cornerRadius(16))
                                            }
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
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Image("percent")
                                        Text(restaurant.discount + " %")
                                        .modifier(TextModifier(size: 14, font: Font.sofiaProSemiBold, color: Color.whiteColor))
                                    }
                                }
                                Spacer()
                            }
                        }
                        .frame(height: 218)
                        .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners])).shadow(color: .shadowColor, radius: 30)
                        .padding(.horizontal, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(options, id: \.self) { option in
                                    Group {
                                        Text(option)
                                        .modifier(TextModifier(size: 32, font: Font.sofiaProBold, color: Color.blackColor))
                                            .opacity(option == self.cType ? 1.0 : 0.16)
                                        .onTapGesture {
                                            self.cType = option
                                        }
                                        
                                        Spacer().frame(width: 18)
                                    }
                                    
                                }
                            }
                        }
                        .padding(.leading, 20)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(fetchFood()) { item in
                                FoodCell(food: item) { food in
                                    self.onTap?(food)
                                }
                                Spacer().frame(height: 16)
                            }
                        }
                    }
                }*/
                ScrollableView($contentOffset, animationDuration: 0.5, action: { value in
                    if value >= 100 {
                        DispatchQueue.main.async {
                            self.onClose?()
                        }
                    }
                }) {
                    VStack(spacing: 30) {
                        ZStack {
                            Image(self.restaurant.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 218)
                            .cornerRadius(30)
                            .contentShape(Rectangle())
                            
                            VStack {
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(self.restaurant.title)
                                        .modifier(TextModifier(size: 24, font: Font.sofiaProBold, color: Color.whiteColor))
                                        .padding(.bottom, 20)
                                        
                                        HStack {
                                            ForEach(0..<3) { index in
                                                Text(index == 0 ? "1.0mi" : (index == 1 ? self.restaurant.type : "$$"))
                                                    .modifier(TextModifier(size: 16, font: Font.sofiaProRegular, color: Color.white))
                                                    .padding(.horizontal, 14)
                                                    .padding(.vertical, 6)
                                                .background(Color.cellColor.cornerRadius(16))
                                            }
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
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Image("percent")
                                        Text(self.restaurant.discount + " %")
                                        .modifier(TextModifier(size: 14, font: Font.sofiaProSemiBold, color: Color.whiteColor))
                                    }
                                }
                                Spacer()
                            }
                        }
                        .frame(height: 218)
                        .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners])).shadow(color: .shadowColor, radius: 30)
                        .padding(.horizontal, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.options, id: \.self) { option in
                                    Group {
                                        Text(option)
                                        .modifier(TextModifier(size: 32, font: Font.sofiaProBold, color: Color.blackColor))
                                            .opacity(option == self.cType ? 1.0 : 0.16)
                                        .onTapGesture {
                                            self.cType = option
                                        }
                                        
                                        Spacer().frame(width: 18)
                                    }
                                    
                                }
                            }
                        }
                        .padding(.leading, 20)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(self.fetchFood()) { item in
                                FoodCell(food: item) { food in
                                    self.onTap?(food)
                                }
                                Spacer().frame(height: 16)
                            }
                        }
                    }
                }
                .frame(width: screenWidth)
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
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
    
    func fetchFood() -> [Food] {
        selectedItems()
    }
    
    func selectedItems() -> [Food] {
        cType == "For You" ? Food.items :
            (cType == "Entrees" ? Food.items1 :
                                    Food.items2)
    }
}

struct FoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        FoodScreen(state: AppState(), restaurant: Resturant.items[0])
    }
}
