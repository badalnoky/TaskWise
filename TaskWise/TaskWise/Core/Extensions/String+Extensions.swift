import Foundation

public extension String {
    static var empty: String = ""
    static var capitalPlacholder = "T"

    func caseInsensitiveContains(_ substring: String) -> Bool {
        self.range(of: substring, options: .caseInsensitive) != nil
    }
}
