@testable import TaskWise
import XCTest

final class RepeatBehaviourTests: XCTestCase {
    func test_encode_shouldReturnString() throws {
        let behaviour = RepeatBehaviour(frequency: .weekly, end: Date(), schedule: .empty)
        let encodedString = behaviour.encoded
        XCTAssertEqual(encodedString, "W/D/1")
    }

    func test_decode_shouldReturnRepeatBehaviour() throws {
        let encodedString = "D"
        let endDate = Date()
        let decodedBehaviour = RepeatBehaviour.decode(encodedString, endDate)
        XCTAssertEqual(decodedBehaviour.frequency, .daily)
        XCTAssertEqual(decodedBehaviour.end, endDate)
        XCTAssertEqual(decodedBehaviour.schedule, .empty)
    }
}
