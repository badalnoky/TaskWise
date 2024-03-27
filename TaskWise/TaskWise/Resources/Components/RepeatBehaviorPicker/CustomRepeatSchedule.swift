public struct CustomRepeatSchedule {
    let unit: RepeatUnit
    let unitFrequency: Int
    let indices: [Int]
}

extension CustomRepeatSchedule {
    static var empty: CustomRepeatSchedule {
        .init(unit: .day, unitFrequency: .plusOne, indices: [])
    }
}
