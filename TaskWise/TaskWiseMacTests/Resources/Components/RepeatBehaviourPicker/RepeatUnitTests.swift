@testable import TaskWiseMac
import Testing

@Suite("RepeatUnit", .tags(.utility))
struct RepeatUnitTests {
    @Test("Decode")
    func decode() {
        #expect(RepeatUnit.decode("D") == .day)
        #expect(RepeatUnit.decode("W") == .week)
        #expect(RepeatUnit.decode("M") == .month)
        #expect(RepeatUnit.decode("Invalid") == .day)
    }
}
