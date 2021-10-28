//
//  WithDefaultDecodableValue.swift
//  
//
//  Created by andrey.antropov on 21.10.2021.
//

import Foundation

@propertyWrapper public struct WithDefaultDecodableValue<T: DefaultedDecodableType>: Codable {
    public let wrappedValue: T
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.wrappedValue = try container.decode(T.self)
        } catch {
            self.wrappedValue = T.valueToUseWhenParsingFailed
        }
    }
    
    public init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
