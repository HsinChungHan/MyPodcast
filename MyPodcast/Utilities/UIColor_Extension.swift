//
//  UIColorExtension.swift
//  LottieAnimationStartedProject
//
//  Created by 辛忠翰 on 13/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    static let myBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let myLightBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func hex (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static let lightRed = UIColor.rgb(red: 247, green: 66, blue: 82)
    static let tealColor = UIColor.rgb(red: 48, green: 164, blue: 184)
    static let darkBlueColor = UIColor.rgb(red: 9, green: 45, blue: 64)
    static let lightBlue = UIColor.rgb(red: 218, green: 235, blue: 243)
    static let skyBlue = UIColor.rgb(red: 123, green: 212, blue: 249)
    static let lightOrange = UIColor.rgb(red: 255, green: 90, blue: 95)
    static let appleGreen = UIColor.rgb(red: 1, green: 209, blue: 193)
    static let darkOrange = UIColor.rgb(red: 255, green: 140, blue: 0)
    static let lightBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static let systemBlue = UIColor.rgb(red: 21, green: 126, blue: 251)
    static let grayBarColor = UIColor.rgb(red: 178, green: 178, blue: 178)
    static let grayBackgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
    static let downOrange = UIColor.rgb(red: 247, green: 174, blue: 174)
    static let upOrange = UIColor.rgb(red: 247, green: 92, blue: 92)
    static let textOrange = UIColor.rgb(red: 247, green: 68, blue: 68)
    static let buttonUpGray = UIColor.rgb(red: 170, green: 170, blue: 170)
    
    static let backgroundRiceColor = UIColor.rgb(red: 254, green: 242, blue: 219)
    
    static let textBrownColor = UIColor.rgb(red: 157, green: 117, blue: 107)
    
    static let buttonDownGradientColor = UIColor.rgb(red: 188, green: 154, blue: 106)
    
    static let buttonUpGradientColor = UIColor.rgb(red: 249, green: 227, blue: 190)
    
    static let bigButtonDownGradientColor = UIColor.rgb(red: 181, green: 143, blue: 132)
    
    static let bigButtonUpGradientColor = UIColor.rgb(red: 213, green: 178, blue: 166)
    
    
    
    
    
    
    
    
    
    static let classicDarkBlack = UIColor.hex(hex: "#040C0E")
    static let classicDarkGreen = UIColor.hex(hex: "#132226")
    static let classicMiddleGreen = UIColor.hex(hex: "#525B56")
    static let classicOrange = UIColor.hex(hex: "#BE9063")
    static let classicBrown = UIColor.hex(hex: "#A4978E")
    static let underWaterBlue = UIColor.hex(hex: "#00e9ff")
    static let lightseagreen = UIColor.hex(hex: "#20B2AA")
    static let firebrickRed = UIColor.hex(hex: "#B22222")
}
