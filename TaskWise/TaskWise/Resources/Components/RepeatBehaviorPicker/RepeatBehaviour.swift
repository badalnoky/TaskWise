import Foundation

public struct RepeatBehaviour {
    var frequency: RepeatFrequency
    var endBehaviour: RepeatEnd
    var end: Date
    var schedule: CustomRepeatSchedule

    init(frequency: RepeatFrequency, endBehaviour: RepeatEnd, end: Date, shedule: CustomRepeatSchedule) {
        self.frequency = frequency
        self.endBehaviour = endBehaviour
        self.end = end
        self.schedule = shedule
    }
}

extension RepeatBehaviour {
    static var empty: RepeatBehaviour {
        RepeatBehaviour(
            frequency: .never,
            endBehaviour: .never,
            end: .now,
            shedule: .empty
        )
    }
}
