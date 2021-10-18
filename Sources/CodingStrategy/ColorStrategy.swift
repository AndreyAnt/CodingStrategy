//
//  ColorStrategy.swift
//  
//
//  Created by andrey.antropov on 18.10.2021.
//

import UIKit

public struct ColorStrategy: CodingStrategy {
    public static func decode(_ value: String) throws -> UIColor {
        let color: UIColor?
        switch value {
        case let string where string.starts(with: "#"):
            color = .green
        default:
            color = nil
        }
        
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
}
