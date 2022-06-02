//
//  Style.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/15/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

extension Color {
    
    static let backgroundColor = Color("backgroundColor")
    static let blackColor = Color("blackColor")
    static let greenColor = Color("greenColor")
    static let pinkColor = Color("pinkColor")
    static let whiteColor = Color("whiteColor")
    static let grayLabelColor = Color("grayLabelColor")
    static let grayButtonColor = Color("grayButtonColor")
    static let shadowColor = Color("shadowColor")
    static let cellColor = Color("cellColor")
    static let barColor = Color("barColor")
    
    static let primaryTextColor = Color("primaryTextColor")
    static let secondaryTextColor = Color("secondaryTextColor")
    static let greyBorderColor = Color("greyBorder")
}

extension UIColor {
    static let homeBackgroundColor = UIColor(named: "homeBackgroundColor") ?? UIColor.white
}

extension Font {
    static let textaAltBlack = "TextaAlt-Black"
    static let textaAltBold = "TextaAlt-Bold"
    static let textaAltHeavy = "TextaAlt-Heavy"
    static let textaHeavy = "Texta-Heavy"
    static let textaBold = "Texta-Bold"
    static let ttNormsBold = "TTNorms-ExtraBold"
    
    static let sofiaProRegular = "sofiapro-regular"
    static let sofiaProBold = "sofiapro-bold"
    static let sofiaProBlack = "sofiapro-black"
    static let sofiaProSemiBold = "sofiapro-semibold"
    static let sofiaProBoldCondensed = "SofiaProBoldCondensed"
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

struct ButtonBounce: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ButtonBounceLight: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
    }
}

struct ButtonBounceNone: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.0 : 1.0)
    }
}

struct ButtonBounceHeavy: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct TextModifier: ViewModifier {
    var size: CGFloat = 18
    var font: String = Font.sofiaProRegular
    var color: Color = Color.primaryTextColor

    func body(content: Content) -> some View {
        content
            .font(Font.custom(font, size: size))
            .foregroundColor(color)
    }
}

struct ProfileButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            ZStack {
//                RoundedRectangle(cornerRadius: 14)
//                    .frame(width: 47, height: 47)
//                    .foregroundColor(Color.whiteColor)
//                RoundedRectangle(cornerRadius: 12)
//                .frame(width: 41, height: 41)
//                .foregroundColor(Color.blackColor)

                Image("profile-pic")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 84, height: 84)
                .cornerRadius(12)
                .padding([.top, .leading], 5)
            }
            .frame(width: 41, height: 41)
        }
    }
}

struct FavoriteButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 47, height: 47)
                    .foregroundColor(Color.whiteColor)
                RoundedRectangle(cornerRadius: 12)
                .frame(width: 41, height: 41)
                .foregroundColor(Color.blackColor)

                Image("favorite-icon")
                .renderingMode(.original)
            }
        }
    }
}

struct FavoriteeButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            Image("favorite-add")
            .renderingMode(.original)
        }
    }
}

struct DownButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            ZStack {
                Color.black.opacity(0.0001)
                    .frame(width: 20, height: 20)
                Image("down-arrow")
                    .renderingMode(.original)
            }
        }
    }
}

struct AddButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }){
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 138, height: 48)
                    .foregroundColor(Color.pinkColor)
                Text("add to cart")
                    .modifier(TextModifier(size: 18, font: Font.sofiaProBold, color: Color.white))
            }
        }
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
