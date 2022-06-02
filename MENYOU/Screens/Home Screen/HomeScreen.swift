//
//  HomeScreen.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/16/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import MapKit
import SwiftUI

struct HomeScreen: View {
    @ObservedObject var state: AppState
    @State var position = CardPosition.middle
    @State var value: CGFloat = 0.0
    @State var isOpen = false
    
    @State var restaurant: Resturant = Resturant.items[0]
    @State var food: Food = Food.items[0]
    
    /*var body: some View {
        ZStack {
            Map()
            
            HStack {
                ProfileButton {
                    self.showProfile()
                }
                    .padding(.leading, 20)
                
                Spacer()
                Image("logo")
                .renderingMode(.original)
                Spacer()
                
                FavoriteButton {
                    self.showFavorite()
                }
                    .padding(.trailing, 20)
            }.padding(.top, 39 - (screenHeight / 2))
            
            if state.showRestaurants {
                /*SlideCard(position: $position) {
                    RestaurantScreen(state: self.state, position: self.$position, onTap: { restaurant in
                        self.restaurant = restaurant
                        self.showFood()
                    })
                }*/
                
                GeometryReader { geometry in
                    BottomSheet( isOpen: self.$isOpen, position: self.$position, value: self.$value, maxHeight: geometry.size.height * 0.768) {
                        RestaurantScreen(state: self.state, position: self.$position, value: self.$value, onTap: { restaurant in
                            self.restaurant = restaurant
                            self.showFood()
                        })
                    }
                }.edgesIgnoringSafeArea(.all)
            }
            
            if state.showProfile {
                ProfileScreen(state: state, onClose: {
                    self.closeProfile()
                })
            }
            
            if state.showFavorites {
                FavoriteScreen(state: state, onClose: {
                    self.closeFavorite()
                }, onTap: { restaurant in
                    self.restaurant = restaurant
                    self.showFood()
                })
            }
            
            if state.showFood {
                FoodScreen(state: state, restaurant: restaurant, onClose: {
                    self.closeFood()
                }, onTap: { food in
                    self.food = food
                    self.showDetail()
                })
            }
            
            if state.showDetail {
                DetailScreen(restaurant: restaurant, food: food, onClose: {
                    self.closeDetail()
                })
            }
        }
    }*/
    
    var body: some View {
        ZStack {
            Map(position: $position)
            
            HStack {
                ProfileButton {
                    self.showProfile()
                }
                    .padding(.leading, 20)
                
                Spacer()
                Image("logo")
                .renderingMode(.original)
                Spacer()
                
                FavoriteButton {
                    self.showFavorite()
                }
                    .padding(.trailing, 20)
            }.padding(.top, 39 - (screenHeight / 2))
            
            GeometryReader { geometry in
                BottomSheet( isOpen: self.$isOpen, position: self.$position, value: self.$value, maxHeight: geometry.size.height * 0.768) {
                    RestaurantScreen(state: self.state, position: self.$position, value: self.$value, onTap: { restaurant in
                        self.restaurant = restaurant
                        self.showFood()
                    })
                }
            }
            //.edgesIgnoringSafeArea(.all)
            .offset(y: state.showRestaurants ? 0 : screenHeight)
            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.6).speed(1.5))
            
            ProfileScreen(state: state, onClose: {
                self.closeProfile()
            })
            .offset(y: state.showProfile ? 0 : screenHeight)
            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.6).speed(1.5))
            
            FavoriteScreen(state: state, onClose: {
                self.closeFavorite()
            }, onTap: { restaurant in
                self.restaurant = restaurant
                self.showFood()
            })
            .offset(y: state.showFavorites ? 0 : screenHeight)
            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.6).speed(1.5))
            
            FoodScreen(state: state, restaurant: restaurant, onClose: {
                self.closeFood()
            }, onTap: { food in
                self.food = food
                self.showDetail()
            })
            .offset(y: state.showFood ? 0 : screenHeight)
            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.6).speed(1.5))
            
            DetailScreen(restaurant: restaurant, food: food, onClose: {
                self.closeDetail()
            })
            .offset(y: state.showDetail ? 0 : screenHeight)
            .animation(Animation.interpolatingSpring(mass: 1, stiffness: 100, damping: 16, initialVelocity: 0.6).speed(1.5))
        }
    }
    
    func showProfile() {
        impact(style: .soft)
        self.position = .bottom
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.state.showProfile = true
        }
    }
    
    func closeProfile() {
        impact(style: .soft)
        state.showRestaurants = true
        state.showProfile = false
    }
    
    func showFavorite() {
        impact(style: .soft)
        self.position = .bottom
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.state.showFavorites = true
        }
    }
    
    func closeFavorite() {
        impact(style: .soft)
        state.showRestaurants = true
        state.showFavorites = false
    }
    
    func showFood() {
        state.showRestaurants = false
        state.showFavorites = false
        state.showFood = true
    }
    
    func closeFood() {
        state.showRestaurants = true
        state.showFood = false
    }
    
    func showDetail() {
        state.showFood = false
        state.showDetail = true
    }
    
    func closeDetail() {
        state.showFood = true
        state.showDetail = false
    }
}
