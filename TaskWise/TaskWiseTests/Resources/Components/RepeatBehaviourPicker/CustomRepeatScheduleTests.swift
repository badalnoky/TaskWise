@testable import TaskWise
import XCTest

final class CustomRepeatScheduleTests: XCTestCase {
    func test_encoded_shouldReturnString() throws {
        let schedule = CustomRepeatSchedule(unit: .week, unitFrequency: 2, indices: [1, 3, 5])
        let encoded = schedule.encoded
        let expectedEncoded = "W/2/1-3-5"

        XCTAssertEqual(encoded, expectedEncoded, "Encoded string should match the expected format")
    }

    func test_decode_shouldReturnCustomRepeatSchedule() throws {
        let encoded = "W/2/1-3-5"
        let decoded = CustomRepeatSchedule.decode(encoded)
        let expectedSchedule = CustomRepeatSchedule(unit: .week, unitFrequency: 2, indices: [1, 3, 5])

        XCTAssertEqual(decoded, expectedSchedule, "Decoded schedule should match the expected schedule")
    }

    func test_encoded_whenCalledWithEmpty_shouldReturnString() throws {
        let schedule = CustomRepeatSchedule.empty
        let encoded = schedule.encoded
        let expectedEncoded = "D/1"

        XCTAssertEqual(encoded, expectedEncoded, "Encoded empty schedule should match the expected format")
    }

    func test_decode_whenCalledWithEmpty_shouldReturnCustomRepeatSchedule() throws {
        let encoded = "D/1"
        let decoded = CustomRepeatSchedule.decode(encoded)
        let expectedSchedule = CustomRepeatSchedule.empty

        XCTAssertEqual(decoded, expectedSchedule, "Decoded empty schedule should match the expected schedule")
    }
}
