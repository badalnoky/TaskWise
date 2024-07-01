@testable import TaskWise
import Testing

@Suite("String+Extensions", .tags(.utility))
struct StringExtensionsTests {
    @Test(
        "Case insensitve contains",
        arguments: zip(["hello", "goodbye"], [true, false])
    )
    func caseInsensitiveContains(word: String, isContained: Bool) {
        let text = "Hello, World!"
        #expect(
            text.caseInsensitiveContains(word) == isContained,
            "The substring \(word) should \(isContained ? String.empty : "not ")be found in 'Hello, World!'"
        )
    }

    @Test("Separator appendment")
    func test_withSeparator_shouldReturnStringWithAppendedSeparator() throws {
        let text = "Hello"
        #expect(text.withSeparator() == "Hello/", "The string should be appended with a separator '/'")
    }

    @Test("Dash appendment")
    func test_withDash_shouldReturnStringWithAppendedDash() throws {
        let text = "Hello"
        #expect(text.withDash() == "Hello-", "The string should be appended with a dash '-'")
    }
}
