@testable import TaskWise
import XCTest

final class StringExtensionsTests: XCTestCase {
    func test_caseInsensitiveContains_whenCalledWithMatchingString_shouldReturnTrue() throws {
        let text = "Hello, World!"
        XCTAssertTrue(text.caseInsensitiveContains("hello"), "The substring 'hello' should be found in 'Hello, World!'")
    }

    func test_caseInsensitiveContains_whenCalledWithNotMatchingString_shouldReturnFalse() throws {
        let text = "Hello, World!"
        XCTAssertFalse(text.caseInsensitiveContains("goodbye"), "The substring 'goodbye' should not be found in 'Hello, World!'")
    }

    func test_withSeparator_shouldReturnStringWithAppendedSeparator() throws {
        let text = "Hello"
        XCTAssertEqual(text.withSeparator(), "Hello/", "The string should be appended with a separator '/'")
    }

    func test_withDash_shouldReturnStringWithAppendedDash() throws {
        let text = "Hello"
        XCTAssertEqual(text.withDash(), "Hello-", "The string should be appended with a dash '-'")
    }
}
