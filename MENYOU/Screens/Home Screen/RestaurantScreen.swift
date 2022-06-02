//
//  RestaurantScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/17/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

enum ResturantFilter {
    case popular
    case nearYou
    case topRated
}

struct RestaurantScreen: View {
    @ObservedObject var state: AppState
    @Binding var position: CardPosition
    @Binding var value: CGFloat
    //@Binding var isOpen: Bool
    
    var onClose: (() -> Void)? = nil
    var onTap: ((Resturant) -> Void)? = nil
    
    let cardHeight: CGFloat = 789
    let bottomPadding: CGFloat = 60
    
    @State private var items = Resturant.items
    
    @State private var text: String = ""
    @State private var keyboardOpen = false
    @State private var isTyping = false
    @State private var updatingState = false
    
    @State private var filter = ResturantFilter.popular
    
    @State private var contentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Capsule().frame(width: 30, height: 8)
                    .foregroundColor(Color.secondary.opacity(0.6))
                .onTapGesture { self.onClose?() }
                
                VStack {
                    ZStack {
                        HStack {
                            Image("search-icon")
                            ZStack {
                                if self.text.isEmpty {
                                    HStack {
                                        Text("search restaurants")
                                            .modifier(TextModifier(size: 16, font: Font.sofiaProRegular))
                                            .foregroundColor(Color.grayLabelColor)
                                            .padding(.leading, 0)
                                            .padding(.bottom, 4)
                                        Spacer()
                                    }
                                }

                                TextView(isFirstResponder: self.keyboardOpen,
                                         returnKeyClosesKeyboard: true,
                                         autoCap: false,
                                         autoCorrect: false,
                                         spellCheck: false,
                                         text: $text,
                                         didEditing: $isTyping,
                                         blackText: false)
                                    .padding(.top, 14)
                                    .accentColor(Color.pinkColor)
                                    .padding(.leading, 0)
                            }
                            .padding(.horizontal, 8)
                            .frame(width: screenWidth - 140, height: 52)
                            .animation(.easeInOut(duration: 0.2))
                            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0).speed(0.8))
                            Spacer()
                        }
                        .padding(.top, 13)
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 50)
                    
                    HStack {
                        Button(action: {
                            self.filter = .popular
                            self.slideUp()
                        }){
                            Text("Popular")
                                .modifier(filter == .popular ?
                                    TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor) :
                                    TextModifier(size: 18, font: Font.sofiaProBold, color: Color.grayButtonColor))
                        }
                        .buttonStyle(ButtonBounce())
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            self.filter = .nearYou
                            self.slideUp()
                        }){
                            Text("Near You")
                            .modifier(filter == .nearYou ?
                                TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor) :
                                TextModifier(size: 18, font: Font.sofiaProBold, color: Color.grayButtonColor))
                        }
                        .buttonStyle(ButtonBounce())
                        
                        Spacer()
                        
                        Button(action: {
                            self.filter = .topRated
                            self.slideUp()
                        }){
                            Text("Top Rated")
                            .modifier(filter == .topRated ?
                                TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor) :
                                TextModifier(size: 18, font: Font.sofiaProBold, color: Color.grayButtonColor))
                        }
                        .buttonStyle(ButtonBounce())
                        .padding(.trailing, 20)
                    }
                    .frame(height: 58)
                    .background(Color.barColor.cornerRadius(radius: 20, corners: [.bottomLeft, .bottomRight]))
                }
                .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners])).shadow(color: .shadowColor, radius: 30)
                .padding(.horizontal, 10)
                
                if position == .bottom {
                    Spacer()
                }
                
                ScrollableView($contentOffset, animationDuration: 0.5, action: { value in
                    if value > 0 {
                        DispatchQueue.main.async {
                            self.value = CGFloat(value)
                            if !self.updatingState {
                                self.position = self.position == .top ? .middle : .bottom
                                
                                /// Trick to restrict recursvie call
                                self.updatingState = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.updatingState = false
                                }
                            }
                        }
                    }
                }) {
                    ForEach(self.fetchRestaurant()) { item in
                        RestaurantCell(restaurant: item) { restaurant in
                            self.onTap?(restaurant)
                        }
                        Spacer().frame(height: 16)
                    }
                    Spacer().frame(height: screenHeight - self.cardHeight)
                }
                .highPriorityGesture(DragGesture())
                .frame(width: screenWidth)
                
                /*ScrollView(.vertical, showsIndicators: false) {
                    ForEach(fetchRestaurant()) { item in
                        RestaurantCell(restaurant: item) { restaurant in
                            self.onTap?(restaurant)
                        }
                        Spacer().frame(height: 16)
                    }
                    Spacer().frame(height: screenHeight - cardHeight)
                }
                .highPriorityGesture(DragGesture())*/
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            //.padding(.bottom, bottomPadding)
            .frame(width: screenWidth, height: screenHeight)
            .background(
                BackgroundBlurView(style: .systemThinMaterialLight)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .cornerRadius(radius: isIPhoneX ? 30 : 18, corners: [.topLeft, .topRight]))
        }
        .edgesIgnoringSafeArea(.bottom)
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
    
    func fetchRestaurant() -> [Resturant] {
        text.isEmpty ? selectedItems() :
            selectedItems().filter({
                $0.title.lowercased().contains(text.lowercased())
            })
    }
    
    func selectedItems() -> [Resturant] {
        filter == .popular ? Resturant.items :
            (filter == .nearYou ? Resturant.items1 :
                                Resturant.items2)
    }
    
    func slideUp() {
        self.text = ""
        self.isTyping = false
        
        DispatchQueue.main.async {
            self.closeKeyboard()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.position = .top
            }
        }
    }
    
    private func closeKeyboard() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        keyWindow!.endEditing(true)
    }
}
