//
//  PalagichevStrategy.swift
//  
//
//  Created by Andrey Antropov on 11.05.2020.
//

import Foundation

public struct PalagichevStrategy: CodingStrategy {
    public static func decode(_ value: String) throws -> Date {
        let date: Date?
        switch value {
        case let string where string.contains("."):
            date = DateFormatter.zMilliseconds.date(from: string)
        case let string where string.contains("Z"):
            date = DateFormatter.z.date(from: string)
        case let string where string.contains("T"):
            date = DateFormatter.iso8601.date(from: string)
        default:
            if let someDate = DateFormatter.some.date(from: value) {
                date = someDate
            } else {
                date = DateFormatter.onlyDate.date(from: value)
            }
        }
        if date != nil {
            return date!
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format!"))
        }
    }
    
    public static func encode(_ date: Date) -> String {
        return DateFormatter.iso8601.string(from: date)
    }
}
