import SwiftUI

public extension Image {
    func fittedToSize(_ size: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}
