//
//  UIColor.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }

    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
    class func hexStr (_ hexStr : NSString, alpha : CGFloat) -> UIColor {
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.white;
        }
    }
    
    class func navigationBarTitleTextColor() -> UIColor {
        return UIColor.hexStr("ffffff", alpha: 1)
    }
    
    class func navigationBarBackgroundColor() -> UIColor {
        return UIColor.hexStr("EA4C89", alpha: 0.85)
    }
    
    class func scrollMenuBackgroundColor() -> UIColor {
        return UIColor.hexStr("ECEFF1", alpha: 1)
    }
    
    class func viewBackgroundColor() -> UIColor {
        return UIColor.hexStr("263238", alpha: 1)
    }
    
    class func selectionIndicatorColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func bottomMenuHairlineColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func selectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("37474F", alpha: 1)
    }
    
    class func unselectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("607D8B", alpha: 1)
    }
    
    class func cellLabelColor() -> UIColor {
        return UIColor.hexStr("546E7A", alpha: 1)
    }

}
