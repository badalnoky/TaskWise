import Foundation
@testable import TaskWise
import Testing

@Suite("RepeatBehaviour", .tags(.utility))
struct RepeatBehaviourTests {
    @Test("Encode")
    func encode() {
        let behaviour = RepeatBehaviour(frequency: .weekly, end: Date(), schedule: .empty)
        let encodedString = behaviour.encoded
        #expect(encodedString == "W/D/1")
    }

    @Test("Decode")
    func decode() {
        let encodedString = "D"
        let endDate = Date()
        let decodedBehaviour = RepeatBehaviour.decode(encodedString, endDate)
        #expect(decodedBehaviour.frequency == .daily)
        #expect(decodedBehaviour.end == endDate)
        #expect(decodedBehaviour.schedule == .empty)
    }
}
