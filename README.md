# CodingStrategy

A description of this package.

Usage:  @CustomCoded<SomeGenericStrategy> var property: GenericType
  
  where SomeGenericStrategy conforms to
  CodingStrategy {
    associatedtype InputType: Codable
    associatedtype OutputType: Codable

    static func decode(_ value: InputType) throws -> GenericType
    static func encode(_ date: GenericType) -> InputType
}

Installation through SPM: https://github.com/AndreyAnt/CodingStrategy.git
