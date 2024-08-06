import Foundation
@testable import TaskWise
import Testing

// swiftlint: disable force_unwrapping
@Suite("Date+Extensions", .tags(.utility))
struct DateExtensionsTests {
    @Test("Grouping dates by day")
    func groupedByDay() {
        let calendar = Calendar.current

        let date1 = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!
        let date2 = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: date1)!
        let date3 = calendar.date(byAdding: .day, value: 1, to: date1)!
        let date4 = calendar.date(byAdding: .day, value: 1, to: date2)!

        let dates = [date1, date2, date3, date4]

        let result = dates.groupedByDay()

        #expect(result.count == 2, "The result should contain two unique days")
        #expect(result.contains(date1), "The result should contain the first date of the first day")
        #expect(result.contains(date3), "The result should contain the first date of the second day")
    }

    @Test("Current month default case")
    func currentMonthDefault() {
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

        #expect(result.count == expectedCount, "The result should contain \(expectedCount) dates")
        #expect(result == dates, "The result should match the expected dates for the current month")
    }

    @Test(
        "Current month is february",
        arguments: zip([2020, 2021], [29, 28])
    )
    func currentMonthFebruary(year: Int, dayCount: Int) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: 2, day: 1)
        let date = calendar.date(from: components)!

        let result = date.currentMonth()

        #expect(result.count == dayCount, "February \(year) should contain \(dayCount) days")
        #expect(calendar.component(.day, from: result.first!) == 1, "The first day should be 1")
        #expect(calendar.component(.day, from: result.last!) == dayCount, "The last day should be \(dayCount)")
    }

    @Test("Calculate dates for a given behaviour")
    func calculateDatesForBehaviour() {
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

        #expect(result.count == 10, "There should be 10 occurrences")
        for (index, occurrence) in result.enumerated() {
            let expectedStart = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1 + index, hour: 10))!
            let expectedEnd = calendar.date(from: DateComponents(year: 2024, month: 5, day: 1 + index, hour: 12))!
            #expect(occurrence.starts == expectedStart, "Start date should match the expected start date")
            #expect(occurrence.ends == expectedEnd, "End date should match the expected end date")
        }
    }
}
