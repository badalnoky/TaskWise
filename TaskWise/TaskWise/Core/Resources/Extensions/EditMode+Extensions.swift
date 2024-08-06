import SwiftUI

extension EditMode {
    static func toggle(mode: inout EditMode) {
        if mode == .inactive {
            mode = .active
        } else {
            mode = .inactive
        }
    }
}
