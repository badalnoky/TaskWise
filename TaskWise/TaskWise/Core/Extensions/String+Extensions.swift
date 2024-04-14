import Foundation

public extension String {
    static var empty: String = ""
    static var capitalPlacholder = "T"
    static var separator = "/"
    static var dash = "-"
    static var space = " "

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

extension String {
    static let colorPickerTitle: String = "Color Picker"
    static let colorHexCodeLabel: String = "Hex Code #"
    static let regex: String = "SELF MATCHES %@"
    static let hexCodeRegex: String = "[0-9A-F]{0,6}"
    static let hashMark: String = "#"

    func hexTranslate(red: inout Int, green: inout Int, blue: inout Int) {
        var rgb: UInt64 = .zero
        Scanner(string: self).scanHexInt64(&rgb)
        red = Int((rgb >> 16) & 0xFF)
        green = Int((rgb >> 8) & 0xFF)
        blue = Int(rgb & 0xFF)
    }
}
