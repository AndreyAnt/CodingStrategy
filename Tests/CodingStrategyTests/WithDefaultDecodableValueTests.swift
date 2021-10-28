import XCTest
@testable import CodingStrategy

final class DefaultedTests: XCTestCase {
    
    struct Fixture: Codable {
        @WithDefaultDecodableValue var data: Int
    }
    
    func testInt() {
        let jsonData = #"{"data": 1}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(decodedObject.data, 1)
    }
    
    func testRawInitializer() {
        let fixture = Fixture(data: .init(1))
        XCTAssertEqual(fixture.data, 1)
    }
        
    func testBadIntInput() {
        let jsonData = #"{"data": "bad_input"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(decodedObject.data, 0)
    }

    static var allTests = [
        ("testInt", testInt),
        ("testRawInitializer", testRawInitializer),
        ("testBadIntInput", testBadIntInput),
    ]
}
