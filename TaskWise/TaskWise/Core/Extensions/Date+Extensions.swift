import Foundation

extension Date {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date.now)
    }
}

extension Array where Element == Date {
    func groupedByDay() -> [Date] {
        var dates: [Date] = []
        for date in self where !dates.contains(where: { compared in Calendar.current.isDate(compared, inSameDayAs: date)}) {
            dates.append(date)
        }
        return dates
    }
}
