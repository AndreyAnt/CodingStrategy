//
//  ColorStrategy.swift
//  
//
//  Created by andrey.antropov on 18.10.2021.
//

import UIKit

public struct ColorStrategy: CodingStrategy {
    public static func decode(_ value: String) throws -> UIColor {
        let color: UIColor? = colorFrom(hexString: value)
        
        if color != nil {
            return color!
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format!"))
        }
    }
    
    public static func encode(_ value: UIColor) -> String {
        let components = value.components
        return "#" + String(components.0 * 255) + String(components.1 * 255) + String(components.2 * 255)
    }
    
    private static func colorFrom(hexString: String) -> UIColor? {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        guard (cString.count) == 6 { return nil }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
