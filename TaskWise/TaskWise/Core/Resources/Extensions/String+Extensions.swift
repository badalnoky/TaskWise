import Foundation

public extension String {
    static var empty: String = ""
    static var capitalPlacholder = "T"
    static var separator = "/"
    static var dash = "-"
    static var space = " "
    static var colon = ":"

    // swiftlint: disable force_cast
    static var groupIdentifierPrefix: String {
        Bundle.main.object(forInfoDictionaryKey: "GroupIdentifierPrefix") as! String
    }
    // swiftlint: enable force_cast

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
