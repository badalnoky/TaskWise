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

extension Date {
    var lastOfMonth: Date {
        Calendar.current.date(byAdding: DateComponents(month: .plusOne, day: .minusOne), to: self.firstOfMonth)!
    }

    var endOfDay: Date {
        let start = Calendar.current.startOfDay(for: self)
        return Calendar.current.date(byAdding: DateComponents(day: .plusOne, second: .minusOne), to: start)!
    }

    // swiftlint: disable: cyclomatic_complexity
    // swiftlint: disable: function_body_length
    static func calculateDates(for behaviour: RepeatBehaviour, starting: Date, endTime: Date) -> [(starts: Date, ends: Date)] {
        var result: [(starts: Date, ends: Date)] = []
        let span = starting.distance(to: endTime)
        var start = starting
        var end = endTime

        var startDayValue: Int = .zero
        var nextIndiceValue: Int = .zero
        var counter: Int = .zero
        if behaviour.schedule.unit == .week {
            startDayValue = Calendar.current.component(.weekday, from: start).weekDayOffset
        } else if behaviour.schedule.unit == .month {
            startDayValue = Calendar.current.component(.day, from: start)
        }
        if behaviour.schedule.unit != .day {
            if behaviour.schedule.indices.last == startDayValue {
                nextIndiceValue = behaviour.schedule.indices.first!
            } else if let greater = behaviour.schedule.indices.first(where: { $0 > startDayValue }) {
                nextIndiceValue = greater
            } else {
                nextIndiceValue = behaviour.schedule.indices.first!
            }
            counter = behaviour.schedule.indices.firstIndex(of: nextIndiceValue)!
        }

        repeat {
            result.append((start, end))
            var shouldSkip = true
            if behaviour.schedule.indices.allSatisfy({ $0 > startDayValue }) {
                shouldSkip = start != starting
            }
            let behaviourIndices = behaviour.schedule.indices
            let normalizedIndex = counter % behaviourIndices.count
            let day = behaviourIndices[normalizedIndex]
            if Calendar.current.component(.day, from: start.lastOfMonth) < day {
                counter += .plusOne
            }
            switch behaviour.frequency {
            case .daily: start = start.followingDays(amount: .plusOne)
            case .weekly: start = start.followingDays(amount: .weekDayCount)
            case .monthly: start = start.followingMonth(startingDay: starting)
            case .yearly: start = start.followingYear(startingDay: starting)
            case .custom:
                switch behaviour.schedule.unit {
                case .day: start = start.followingDays(amount: behaviour.schedule.unitFrequency)
                case .week: start = start.followingCustomScheduledDay(currentIndex: counter, behaviour: behaviour, shouldSkip: shouldSkip)
                case .month:  start = start.followingCustomScheduledDay(currentIndex: counter, behaviour: behaviour, shouldSkip: shouldSkip)
                }
            default: start = behaviour.end.endOfDay.addingTimeInterval(.one)
            }
            end = start.addingTimeInterval(span)
            counter += .plusOne
        } while start < behaviour.end.endOfDay
        return result
    }
    // swiftlint: enable: cyclomatic_complexity
    // swiftlint: enable: function_body_length

    func followingDays(amount: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: amount, to: self)!
    }

    func followingMonth(startingDay: Date) -> Date {
        let startDay = Calendar.current.component(.day, from: startingDay)
        let startHour = Calendar.current.component(.hour, from: startingDay)
        let startMinute = Calendar.current.component(.minute, from: startingDay)
        return Calendar.current.nextDate(
            after: self,
            matching: .init(day: startDay, hour: startHour, minute: startMinute),
            matchingPolicy: .previousTimePreservingSmallerComponents
        )!
    }

    func followingYear(startingDay: Date) -> Date {
        let startMonth = Calendar.current.component(.month, from: startingDay)
        let startDay = Calendar.current.component(.day, from: startingDay)
        let startHour = Calendar.current.component(.hour, from: startingDay)
        let startMinute = Calendar.current.component(.minute, from: startingDay)
        return Calendar.current.nextDate(
            after: self,
            matching: .init(month: startMonth, day: startDay, hour: startHour, minute: startMinute),
            matchingPolicy: .previousTimePreservingSmallerComponents
        )!
    }

    func followingCustomScheduledDay(currentIndex: Int, behaviour: RepeatBehaviour, shouldSkip: Bool) -> Date {
        let behaviourIndices = behaviour.schedule.indices
        let normalizedIndex = currentIndex % behaviourIndices.count
        let day = behaviourIndices[normalizedIndex]
        var date = self

        if behaviour.schedule.unitFrequency != .plusOne, normalizedIndex == .zero, shouldSkip {
            if behaviour.schedule.unit == .week {
                date = Calendar.current.date(byAdding: .day, value: .weekDayCount * (behaviour.schedule.unitFrequency - .plusOne), to: date)!
            } else if behaviour.schedule.unit == .month {
                date = Calendar.current.date(byAdding: .month, value: (behaviour.schedule.unitFrequency - .plusOne), to: date)!
            }
        }
        return Calendar.current.nextDate(
            after: date,
            matching: behaviour.schedule.unit == .week ? .init(weekday: day.weekdayIndice) : .init(day: day),
            matchingPolicy: .previousTimePreservingSmallerComponents
        )!
    }
}
// swiftlint: enable: force_unwrapping
