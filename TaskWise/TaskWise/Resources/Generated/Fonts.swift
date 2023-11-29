// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

public enum Fonts {
    public enum ProximaNova {
        public static let bold = FontAsset(name: "ProximaNova-Bold")
    }
}

public final class FontAsset {
    public private(set) var name: String

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension FontAsset {
    func font(size: CGFloat) -> Font {
        .custom(name, fixedSize: size)
    }
}
