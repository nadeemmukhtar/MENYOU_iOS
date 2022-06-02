//
//  FoodCell.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/29/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct FoodCell: View {
    
    var food: Food
    var onTap: ((Food) -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    ZStack {
                        Image(food.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 84, height: 84)
                            .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(food.title)
                        .modifier(TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor))
                        .animation(nil)
                        
                        Text(food.detail)
                        .modifier(TextModifier(size: 16, font: Font.sofiaProRegular, color: Color.primaryTextColor))
                        .animation(nil)
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
                        Image("price")
                        Text("$" + food.price)
                        .modifier(TextModifier(size: 14, font: Font.sofiaProSemiBold, color: Color.whiteColor))
                    }
                }
                Spacer()
            }
        .frame(width: screenWidth - 30, height: 108)
        }
        .onTapGesture {
            self.onTap?(self.food)
        }
    }
}

struct FoodCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodCell(food: Food.items[0])
    }
}
