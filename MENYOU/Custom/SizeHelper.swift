//
//  SizeHelper.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/17/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import UIKit
import Foundation

let screenSize = UIScreen.main.bounds.size
let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width
let screenCenter = CGPoint(x: screenWidth / 2.0, y: screenHeight / 2.0)
let screenRect = CGRect(origin: .zero, size: screenSize)

let height = UIScreen.main.nativeBounds.height
let isIPhoneX: Bool = height == 2436 || height == 2688 || height == 1792
let isIPhoneXMax: Bool = height == 2688
let isIPhoneXR: Bool = height == 1792
let isIPhoneSE: Bool = height == 1136
let isIPhonePlus: Bool = height == 2208
let isIPhone: Bool = height == 1334
let isIPad: Bool = height == 2048 || height == 2224 || height == 2732
let isIPadPro: Bool = height == 2732
let isIPadRegular: Bool = height == 2048 || height == 2224
