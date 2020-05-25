import XCTest
@testable import CodingStrategy

final class CodingStrategyTests: XCTestCase {
    
    struct Fixture: Codable {
        @CustomCoded<PalagichevStrategy> var date: Date
    }
    var calendar = Calendar.current
    
    func testZDateFormat() {
        let jsonData = #"{"date": "2016-06-27T08:15:17Z"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        calendar.timeZone = TimeZone(identifier: "UTC")!

        let year = calendar.component(.year, from: decodedObject.date)
        XCTAssertEqual(year, 2016)
        let month = calendar.component(.month, from: decodedObject.date)
        XCTAssertEqual(month, 6)
        let day = calendar.component(.day, from: decodedObject.date)
        XCTAssertEqual(day, 27)
        let hour = calendar.component(.hour, from: decodedObject.date)
        XCTAssertEqual(hour, 8)
        let minute = calendar.component(.minute, from: decodedObject.date)
        XCTAssertEqual(minute, 15)
        let seconds = calendar.component(.second, from: decodedObject.date)
        XCTAssertEqual(seconds, 17)
        let nanoseconds = calendar.component(.nanosecond, from: decodedObject.date)
        XCTAssertEqual(nanoseconds, 0)
    }
    
    func testZMillisecondsDateFormat() {
        let jsonData = #"{"date": "2016-06-02T21:09:24.852Z"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let year = calendar.component(.year, from: decodedObject.date)
        XCTAssertEqual(year, 2016)
        let month = calendar.component(.month, from: decodedObject.date)
        XCTAssertEqual(month, 6)
        let day = calendar.component(.day, from: decodedObject.date)
        XCTAssertEqual(day, 2)
        let hour = calendar.component(.hour, from: decodedObject.date)
        XCTAssertEqual(hour, 21)
        let minute = calendar.component(.minute, from: decodedObject.date)
        XCTAssertEqual(minute, 9)
        let seconds = calendar.component(.second, from: decodedObject.date)
        XCTAssertEqual(seconds, 24)
        let nanoseconds = Double(calendar.component(.nanosecond, from: decodedObject.date))
        let milliseconds = (nanoseconds/1_000_000).rounded()
        XCTAssertEqual(milliseconds, 852)
    }
    
    func testISO8601DateFormat() {
        let jsonData = #"{"date": "2016-06-26T17:38:42+03:00"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        calendar.timeZone = TimeZone(identifier: "Europe/Moscow")!

        let year = calendar.component(.year, from: decodedObject.date)
        XCTAssertEqual(year, 2016)
        let month = calendar.component(.month, from: decodedObject.date)
        XCTAssertEqual(month, 6)
        let day = calendar.component(.day, from: decodedObject.date)
        XCTAssertEqual(day, 26)
        let hour = calendar.component(.hour, from: decodedObject.date)
        XCTAssertEqual(hour, 17)
        let minute = calendar.component(.minute, from: decodedObject.date)
        XCTAssertEqual(minute, 38)
        let seconds = calendar.component(.second, from: decodedObject.date)
        XCTAssertEqual(seconds, 42)
        let nanoseconds = calendar.component(.nanosecond, from: decodedObject.date)
        XCTAssertEqual(nanoseconds, 0)
    }
    
    func testOnlyDateDateFormat() {
        let jsonData = #"{"date": "2016-06-26T17:38:42+03:00"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        calendar.timeZone = TimeZone(identifier: "Europe/Moscow")!

        let year = calendar.component(.year, from: decodedObject.date)
        XCTAssertEqual(year, 2016)
        let month = calendar.component(.month, from: decodedObject.date)
        XCTAssertEqual(month, 6)
        let day = calendar.component(.day, from: decodedObject.date)
        XCTAssertEqual(day, 26)
        let hour = calendar.component(.hour, from: decodedObject.date)
        XCTAssertEqual(hour, 17)
        let minute = calendar.component(.minute, from: decodedObject.date)
        XCTAssertEqual(minute, 38)
        let seconds = calendar.component(.second, from: decodedObject.date)
        XCTAssertEqual(seconds, 42)
        let nanoseconds = calendar.component(.nanosecond, from: decodedObject.date)
        XCTAssertEqual(nanoseconds, 0)
    }
    
    func testSomeDateFormat() {
        let jsonData = #"{"date": "2018-01-18 09:45:06 +0300"}"#.data(using: .utf8)!
        let decodedObject = try! JSONDecoder().decode(Fixture.self, from: jsonData)
        calendar.timeZone = TimeZone(identifier: "Europe/Moscow")!

        let year = calendar.component(.year, from: decodedObject.date)
        XCTAssertEqual(year, 2018)
        let month = calendar.component(.month, from: decodedObject.date)
        XCTAssertEqual(month, 01)
        let day = calendar.component(.day, from: decodedObject.date)
        XCTAssertEqual(day, 18)
        let hour = calendar.component(.hour, from: decodedObject.date)
        XCTAssertEqual(hour, 9)
        let minute = calendar.component(.minute, from: decodedObject.date)
        XCTAssertEqual(minute, 45)
        let seconds = calendar.component(.second, from: decodedObject.date)
        XCTAssertEqual(seconds, 6)
        let nanoseconds = calendar.component(.nanosecond, from: decodedObject.date)
        XCTAssertEqual(nanoseconds, 0)
    }
    
    func testBadInput() {
        let jsonData = #"{"date": "blah-blah-blah"}"#.data(using: .utf8)!
        var thrownError: Error?
        
        XCTAssertThrowsError(try JSONDecoder().decode(Fixture.self, from: jsonData)) {
            thrownError = $0
        }
        
        XCTAssertTrue(thrownError is DecodingError)
    }

    static var allTests = [
        ("testZDateFormat", testZDateFormat),
        ("testZMillisecondsDateFormat", testZMillisecondsDateFormat),
        ("testISO8601DateFormat", testISO8601DateFormat),
        ("testOnlyDateDateFormat", testOnlyDateDateFormat),
        ("testSomeDateFormat", testSomeDateFormat),
        ("testBadInput", testBadInput),
    ]
}
