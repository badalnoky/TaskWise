import SwiftUI

extension UIScreen {
    static var isPhone: Bool {
        UIScreen.main.traitCollection.userInterfaceIdiom != .pad
    }

    static var isPad: Bool {
        UIScreen.main.traitCollection.userInterfaceIdiom == .pad
    }
}
