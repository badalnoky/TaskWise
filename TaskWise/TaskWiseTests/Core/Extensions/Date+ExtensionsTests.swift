@testable import TaskWise
import XCTest

// swiftlint: disable: force_unwrapping
final class DateExtensionsTests: XCTestCase {
    func test_groupedByDay_shouldReturnFilteredArray() throws {
        let calendar = Calendar.current

        let date1 = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!
        let date2 = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: date1)!
        let date3 = calendar.date(byAdding: .day, value: 1, to: date1)!
        let date4 = calendar.date(byAdding: .day, value: 1, to: date2)!

        let dates = [date1, date2, date3, date4]

        let result = dates.groupedByDay()

        XCTAssertEqual(result.count, 2, "The result should contain two unique days")
        XCTAssertTrue(result.contains(date1), "The result should contain the first date of the first day")
        XCTAssertTrue(result.contains(date3), "The result should contain the first date of the second day")
    }

    func test_currentMonth_shouldReturnArrayOfAMonth() throws {
        let calendar = Calendar.current
        let today = Date()

        let components = calendar.dateComponents([.year, .month], from: today)
        let firstOfMonth = calendar.date(from: components)!

        let range = calendar.range(of: .day, in: .month, for: today)!
        let expectedCount = range.count

        var dates: [Date] = []
        for day in range {
            let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth)!
            dates.append(date)
        }

        let result = today.currentMonth()

        XCTAssertEqual(result.count, expectedCount, "The result should contain \(expectedCount) dates")
        XCTAssertEqual(result, dates, "The result should match the expected dates for the current month")
    }

    func test_currentMonth_whenCalledWithLeapYearFebruary_shouldReturnArrayOfAMonth() throws {
        let calendar = Calendar.current
        let components = DateComponents(year: 2020, month: 2, day: 1)
        let date = calendar.date(from: components)!

        let result = date.currentMonth()

        XCTAssertEqual(result.count, 29, "February 2020 should contain 29 days")
        XCTAssertEqual(calendar.component(.day, from: result.first!), 1, "The first day should be 1")
        XCTAssertEqual(calendar.component(.day, from: result.last!), 29, "The last day should be 29")
    }

    func test_currentMonth_whenCalledWithNonLeapYearFebruary_shouldReturnArrayOfAMonth() throws {
        let calendar = Calendar.current
        let components = DateComponents(year: 2021, month: 2, day: 1)
        let date = calendar.date(from: components)!

        let result = date.currentMonth()

        XCTAssertEqual(result.count, 28, "February 2021 should contain 28 days")
        XCTAssertEqual(calendar.component(.day, from: result.first!), 1, "The first day should be 1")
        XCTAssertEqual(calendar.component(.day, from: result.last!), 28, "The last day should be 28")
    }

    func test_calculateDates_shouldReturnArrayForBehaviour() throws {
        let calendar = Calendar.current
        let originalStart = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1, hour: 10))!
        let endTime = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1, hour: 12))!
        let schedule = CustomRepeatSchedule(unit: .day, unitFrequency: 1, indices: [])
        let behaviour = RepeatBehaviour(
            frequency: .daily,
            end: calendar.date(from: DateComponents(year: 2024, month: 5, day: 10))!,
            schedule: schedule
        )
        let result = Date.calculateDates(for: behaviour, starting: originalStart, endTime: endTime)

        XCTAssertEqual(result.count, 10, "There should be 10 occurrences")
        for (index, occurrence) in result.enumerated() {
            let expectedStart = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1 + index, hour: 10))!
            let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1 + index, hour: 12))!
            XCTAssertEqual(occurrence.starts, expectedStart, "Start date should match the expected start date")
            XCTAssertEqual(occurrence.ends, expectedEnd, "End date should match the expected end date")
        }
    }
}
