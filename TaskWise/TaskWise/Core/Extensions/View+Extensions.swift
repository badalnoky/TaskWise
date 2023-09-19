import SwiftUI

extension View {
    func sized(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}
