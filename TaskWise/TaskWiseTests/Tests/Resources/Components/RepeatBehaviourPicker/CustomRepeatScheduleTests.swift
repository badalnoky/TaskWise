@testable import TaskWise
import Testing

@Suite("CustomRepeatSchedule", .tags(.utility))
struct CustomRepeatScheduleTests {
    @Test(
        "Encoded",
        arguments: zip(
            [CustomRepeatSchedule(unit: .week, unitFrequency: 2, indices: [1, 3, 5]), CustomRepeatSchedule.empty],
            ["W/2/1-3-5", "D/1"]
        )
    )
    func encoded(schedule: CustomRepeatSchedule, encoded: String) {
        let result = schedule.encoded
        #expect(result == encoded, "Encoded string should match the expected format")
    }

    @Test(
        "Decode",
        arguments: zip(
            [CustomRepeatSchedule(unit: .week, unitFrequency: 2, indices: [1, 3, 5]), CustomRepeatSchedule.empty],
            ["W/2/1-3-5", "D/1"]
        )
    )
    func decode(schedule: CustomRepeatSchedule, encoded: String) {
        let result = CustomRepeatSchedule.decode(encoded)
        #expect(result == schedule, "Decoded schedule should match the expected schedule")
    }
}
