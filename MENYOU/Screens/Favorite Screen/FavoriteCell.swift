//
//  FavoriteCell.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/27/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct FavoriteCell: View {
    
    var favorite: Favorite
    var onTap: ((Resturant) -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    ZStack {
                        Image(favorite.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 84, height: 84)
                            .cornerRadius(12)
                        Image("favorite-icon")
                        .renderingMode(.original)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(favorite.title)
                        .modifier(TextModifier(size: 18, font: Font.sofiaProBold, color: Color.blackColor))
                        
                        HStack {
                            ForEach(0..<2) { index in
                                Text(index == 0 ? self.favorite.type : "$$")
                                .modifier(TextModifier(size: 16, font: Font.sofiaProRegular))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
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
                        Text(favorite.discount + " %")
                        .modifier(TextModifier(size: 14, font: Font.sofiaProSemiBold, color: Color.whiteColor))
                    }
                }
                Spacer()
            }
        .frame(width: screenWidth - 30, height: 108)
        }
        .onTapGesture {
            let restaurant = Resturant.init(
                id: self.favorite.id,
                title: self.favorite.title,
                image: self.favorite.image,
                type: self.favorite.type,
                discount: self.favorite.discount)
            self.onTap?(restaurant)
        }
    }
}
