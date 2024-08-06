import Foundation

public extension String {
    static var empty: String = ""
    static var capitalPlacholder = "T"
    static var separator = "/"
    static var dash = "-"
    static var space = " "
    static var colon = ":"

    static func dashboardLink(index: Int) -> String {
        "TaskWiseApp://Dashboard/\(index)"
    }
    static func taskLink(id: UUID) -> String {
        "TaskWiseApp://Dashboard/Task/\(id)"
    }

    func caseInsensitiveContains(_ substring: String) -> Bool {
        self.range(of: substring, options: .caseInsensitive) != nil
    }

    func withSeparator() -> String {
        self + .separator
    }
    func withDash() -> String {
        self + .dash
    }
}
