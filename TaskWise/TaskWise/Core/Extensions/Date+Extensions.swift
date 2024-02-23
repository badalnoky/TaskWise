import Foundation

extension Date {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date.now)
    }

    static var endOfToday: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        // swiftlint: disable: force_unwrapping
        return Calendar.current.date(byAdding: components, to: startOfToday)!
        // swiftlint: enable: force_unwrapping
    }
}

extension Array where Element == Date {
    func groupedByDay() -> [Date] {
        var dates: [Date] = []
        for date in self where !dates.contains(where: { compared in
            Calendar.current.isDate(compared, inSameDayAs: date)
        }) {
            dates.append(date)
        }
        return dates
    }
}

// swiftlint: disable: force_unwrapping
extension Date {
    static var currentYearAsInt: Int {
        Calendar.current.dateComponents(in: .current, from: .now).year!
    }

    static var currentMonthAsInt: Int {
        Calendar.current.dateComponents(in: .current, from: .now).month!
    }

    static var currentYearRange: [Int] {
        Array((Date.currentYearAsInt - .defaultTimeframe)...(currentYearAsInt + .defaultTimeframe))
    }

    var firstOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }

    var nextMonth: Date {
        Calendar.current.date(byAdding: .month, value: .plusOne, to: self)!
    }

    var previousMonth: Date {
        Calendar.current.date(byAdding: .month, value: .minusOne, to: self)!
    }

    func currentMonth() -> [Date] {
        let range = Calendar.current.range(of: .day, in: .month, for: self)!
        var date = self.firstOfMonth
        var dates: [Date] = []
        for _ in range {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: .plusOne, to: date)!
        }
        return dates
    }

    func monthPreset() -> Int {
        Calendar.current.component(.weekday, from: self.firstOfMonth).weekDayOffset
    }

    func monthPostset() -> Int {
        .weekDayCount - ((self.monthPreset() + self.currentMonth().count) % .weekDayCount)
    }
}
// swiftlint: enable: force_unwrapping
