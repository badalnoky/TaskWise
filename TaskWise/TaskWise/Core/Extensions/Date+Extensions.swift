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
