public struct CustomRepeatSchedule {
    let unit: RepeatUnit
    let unitFrequency: Int
    let indices: [Int]
}

extension CustomRepeatSchedule {
    static var empty: CustomRepeatSchedule {
        .init(unit: .day, unitFrequency: .plusOne, indices: [])
    }

    var encoded: String {
        var encoded: String = .empty
        encoded += unit.encoded.withSeparator()
        encoded += String(unitFrequency).withSeparator()
        for index in self.indices {
            encoded += String(index).withDash()
        }
        encoded.removeLast(.one)
        return encoded
    }

    static func decode(_ encoded: String) -> CustomRepeatSchedule {
        let elements = encoded.split(separator: String.separator)
        let unit = RepeatUnit.decode(String(elements[.zero]))
        let frequency = Int(elements[.one]) ?? .zero
        let strIndices = String(elements[.two]).split(separator: String.dash)
        let indices = strIndices.map { Int($0) ?? .zero }
        return CustomRepeatSchedule(unit: unit, unitFrequency: frequency, indices: indices)
    }
}
