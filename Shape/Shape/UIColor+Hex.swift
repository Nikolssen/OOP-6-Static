//
//  UIColor+Hex.swift
//  Shape
//
//  Created by Admin on 12.05.2021.
//

import Foundation
import UIKit

extension UIColor{
    public convenience init(red: Int, green: Int, blue: Int){
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }

    public func rgbDescription() -> (red: Int, green: Int, blue: Int) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    public func hexDescription() -> String {
        let rgb = self.rgbDescription()
        return String(format: "#%02X%02X%02X", rgb.red, rgb.green, rgb.blue)
    }
    
    public convenience init(hex: String) {
        var start = hex.index(after: hex.startIndex)
        var last = hex.index(start, offsetBy: 1)
        var substring = hex[start...last]
        
        let red = Int(substring, radix: 16) ?? 0
        start = hex.index(after: last)
        last  = hex.index(start, offsetBy: 1)
        substring = hex[start...last]
        let green = Int(substring, radix: 16) ?? 0
        start = hex.index(after: last)
        last = hex.index(start, offsetBy: 1)
        substring = hex[start...last]
        let blue = Int(substring, radix: 16) ?? 0
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
}
