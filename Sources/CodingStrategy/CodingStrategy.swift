import Foundation

public protocol CodingStrategy {
    associatedtype InputType: Codable
    associatedtype OutputType: Codable

    static func decode(_ value: InputType) throws -> OutputType
    static func encode(_ date: OutputType) -> InputType
}

@propertyWrapper public struct CustomCoded<Coder: CodingStrategy>: Codable {
    private let rawValue: Coder.InputType
    public var wrappedValue: Coder.OutputType

    public init(wrappedValue: Coder.OutputType) {
        self.wrappedValue = wrappedValue
        self.rawValue = Coder.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.rawValue = try Coder.InputType(from: decoder)
        self.wrappedValue = try Coder.decode(rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}
