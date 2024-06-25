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
    var firstOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
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
    static func calculateDates(for behaviour: RepeatBehaviour, starting originalStart: Date, endTime: Date) -> [(starts: Date, ends: Date)] {
        var result: [(starts: Date, ends: Date)] = []
        let span = originalStart.distance(to: endTime)
        var start = originalStart
        var end = endTime

        var startDayValue: Int = .zero
        var nextIndiceValue: Int = .zero
        var counter: Int = .zero
        startDayValue = start.calculateStartDayValue(behaviour, value: startDayValue)
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
            let shouldSkip = calculateShouldSkip(behaviour, startDayValue: startDayValue, isOriginalDate: start != originalStart)
            counter += start.nextCounter(behaviour, counter: counter)
            switch behaviour.frequency {
            case .daily: start = start.followingDays(amount: .plusOne)
            case .weekly: start = start.followingDays(amount: .weekDayCount)
            case .monthly: start = start.followingMonth(startingDay: originalStart)
            case .yearly: start = start.followingYear(startingDay: originalStart)
            case .custom: start = start.calculateDatesForCustomBehaviour(behaviour, counter: counter, shouldSkip: shouldSkip)
            default: start = behaviour.end.endOfDay.addingTimeInterval(.one)
            }
            end = start.addingTimeInterval(span)
            counter += .plusOne
        } while start < behaviour.end.endOfDay
        return result
    }
    // swiftlint: enable: cyclomatic_complexity
    // swiftlint: enable: function_body_length

    private static func calculateShouldSkip(_ behaviour: RepeatBehaviour, startDayValue: Int, isOriginalDate: Bool) -> Bool {
        if behaviour.schedule.indices.allSatisfy({ $0 > startDayValue }) {
            return isOriginalDate
        }
        return true
    }

    private func calculateStartDayValue(_ behaviour: RepeatBehaviour, value: Int) -> Int {
        if behaviour.schedule.unit == .week {
            return Calendar.current.component(.weekday, from: self).weekDayOffset
        } else if behaviour.schedule.unit == .month {
            return Calendar.current.component(.day, from: self)
        }
        return value
    }

    private func nextCounter(_ behaviour: RepeatBehaviour, counter: Int) -> Int {
        var behaviourIndices: [Int]
        var normalizedIndex: Int
        var day: Int
        if !behaviour.schedule.indices.isEmpty {
            behaviourIndices = behaviour.schedule.indices
            normalizedIndex = counter % behaviourIndices.count
            day = behaviourIndices[normalizedIndex]
            if Calendar.current.component(.day, from: self.lastOfMonth) < day {
                return .plusOne
            }
        }
        return .zero
    }

    private func calculateDatesForCustomBehaviour(_ behaviour: RepeatBehaviour, counter: Int, shouldSkip: Bool) -> Date {
        switch behaviour.schedule.unit {
        case .day: return self.followingDays(amount: behaviour.schedule.unitFrequency)
        case .week: return self.followingCustomScheduledDay(currentIndex: counter, behaviour: behaviour, shouldSkip: shouldSkip)
        case .month:  return self.followingCustomScheduledDay(currentIndex: counter, behaviour: behaviour, shouldSkip: shouldSkip)
        }
    }

    private func followingDays(amount: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: amount, to: self)!
    }

    private func followingMonth(startingDay: Date) -> Date {
        let startDay = Calendar.current.component(.day, from: startingDay)
        let startHour = Calendar.current.component(.hour, from: startingDay)
        let startMinute = Calendar.current.component(.minute, from: startingDay)
        return Calendar.current.nextDate(
            after: self,
            matching: .init(day: startDay, hour: startHour, minute: startMinute),
            matchingPolicy: .previousTimePreservingSmallerComponents
        )!
    }

    private func followingYear(startingDay: Date) -> Date {
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

    private func followingCustomScheduledDay(currentIndex: Int, behaviour: RepeatBehaviour, shouldSkip: Bool) -> Date {
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
