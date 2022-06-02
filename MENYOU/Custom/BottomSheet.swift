//
//  BottomSheet.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 8/19/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var isOpen: Bool
    @Binding var position: CardPosition {
        didSet {
            if position == .middle || position == .bottom {
                closeKeyboard()
            }
        }
    }
    @Binding var value: CGFloat

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    init(isOpen: Binding<Bool>, position: Binding<CardPosition>, value: Binding<CGFloat>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
        self._position = position
        self._value = value
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                //self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: screenHeight, alignment: .top)
            //.background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(self.position.rawValue + self.translation + self.value, 0))
            //.offset(y: self.position.rawValue + self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    //self.isOpen = value.translation.height < 0
                    
                    let verticalDirection = value.predictedEndLocation.y - value.location.y
                    let cardTopEdgeLocation = self.position.rawValue + value.translation.height
                    let positionAbove: CardPosition
                    let positionBelow: CardPosition
                    let closestPosition: CardPosition
                    
                    if cardTopEdgeLocation <= CardPosition.middle.rawValue {
                        positionAbove = .top
                        positionBelow = .middle
                    } else {
                        positionAbove = .middle
                        positionBelow = .bottom
                    }
                    
                    if (cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation) {
                        closestPosition = positionAbove
                    } else {
                        closestPosition = positionBelow
                    }
                    
                    if verticalDirection > 0 {
                        self.position = positionBelow
                    } else if verticalDirection < 0 {
                        self.position = positionAbove
                    } else {
                        self.position = closestPosition
                    }
                }
            )
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

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.282
}
