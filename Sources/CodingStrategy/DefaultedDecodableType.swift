//
//  DefaultedDecodableType.swift
//  
//
//  Created by andrey.antropov on 21.10.2021.
//

import Foundation

public protocol DefaultedDecodableType: Codable {
    static var valueToUseWhenParsingFailed: Self { get }
}

extension Int: DefaultedDecodableType {
    public static var valueToUseWhenParsingFailed: Int { 0 }
}

extension String: DefaultedDecodableType {
    public static var valueToUseWhenParsingFailed: String { "" }
}

extension Double: DefaultedDecodableType {
    public static var valueToUseWhenParsingFailed: Double { 0.0 }
}
