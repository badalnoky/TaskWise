// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
// Template created by: Bertalan Dálnoky

import Foundation
internal enum Str {
    /// Example test
    internal static let example = String(localized: "example", defaultValue: "Example test")
    /// This is the second example
    internal static let secondExample = String(localized: "secondExample", defaultValue: "This is the second example")
}

extension Str {
    private static func stringFrom(format: String, with args: CVarArg...) -> String {
        String(format: format, locale: Locale.current, arguments: args)
    }
}
