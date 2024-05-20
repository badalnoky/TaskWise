@testable import TaskWise
import XCTest

final class RepeatUnitTests: XCTestCase {
    func test_decode_shouldReturnRepeatUnit() throws {
        XCTAssertEqual(RepeatUnit.decode("D"), .day)
        XCTAssertEqual(RepeatUnit.decode("W"), .week)
        XCTAssertEqual(RepeatUnit.decode("M"), .month)
        XCTAssertEqual(RepeatUnit.decode("Invalid"), .day)
    }
}
