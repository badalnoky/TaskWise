import Foundation

public struct RepeatBehaviour {
    var frequency: RepeatFrequency
    var end: Date
    var schedule: CustomRepeatSchedule

    init(frequency: RepeatFrequency, end: Date, shedule: CustomRepeatSchedule) {
        self.frequency = frequency
        self.end = end
        self.schedule = shedule
    }
}

extension RepeatBehaviour {
    static var empty: RepeatBehaviour {
        RepeatBehaviour(
            frequency: .never,
            end: .now,
            shedule: .empty
        )
    }

    var encoded: String {
        var encoded: String = .empty
        encoded += frequency.encoded.withSeparator()
        encoded += schedule.encoded
        return encoded
    }

    static func decode(_ encoded: String, _ endDate: Date) -> RepeatBehaviour {
        let elements = encoded.split(separator: String.separator, maxSplits: .one)
        let frequency = RepeatFrequency.decode(String(elements[.zero]))
        var schedule = CustomRepeatSchedule.empty
        if frequency == .custom {
            schedule = CustomRepeatSchedule.decode(String(elements[.one]))
        }
        return RepeatBehaviour(frequency: frequency, end: endDate, shedule: schedule)
    }
}
