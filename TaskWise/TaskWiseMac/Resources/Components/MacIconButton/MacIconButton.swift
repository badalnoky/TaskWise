import SwiftUI

struct MacIconButton {
    var image: Image
    var action: () -> Void

    init(
        image: Image,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.action = action
    }
}

extension MacIconButton: View {
    var body: some View {
        Button(action: action) {
            image
                .fittedToSize(.defaultIconSize)
        }
        .buttonStyle(IconButtonStyle())
    }
}
