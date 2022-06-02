//
//  RestaurantCell.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/21/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct RestaurantCell: View {
    
    /*var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image("placeholder")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 84, height: 84)
                .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text("Gjelina")
                    .frame(width: screenWidth - 200, height: 36)
                    
                    HStack {
                        ForEach(0..<2) { _ in
                            Text("Vegetarian")
                        }
                    }
                }
                
                ZStack {
                    Image("percent")
                    Text("70 %")
                }
            }
            .frame(height: 108)
            .padding(.leading, 12)
        }
        .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners]))
        .padding(.horizontal, 10)
    }*/
    
    var restaurant: Resturant
    
    var onTap: ((Resturant) -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Image(restaurant.image)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 84, height: 84)
                        .cornerRadius(12)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(restaurant.title)
                        .modifier(TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor))
                        .animation(nil)
                        
                        HStack {
                            ForEach(0..<2) { index in
                                Text(index == 0 ? self.restaurant.type : "$$")
                                .modifier(TextModifier(size: 16, font: Font.sofiaProRegular))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                .animation(nil)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.primaryTextColor, lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 50)
                    Spacer()
                }
                .frame(height: 108)
                .padding(.leading, 12)
            }
            .frame(width: screenWidth - 30, height: 108)
            .background(Color.white.cornerRadius(radius: 20, corners: [.allCorners])).shadow(color: .shadowColor, radius: 5)
            .padding(.horizontal, 10)
            
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
        .frame(width: screenWidth - 30, height: 108)
        }
        .onTapGesture {
            self.onTap?(self.restaurant)
        }
    }
}
