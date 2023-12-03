import SwiftUI

// swiftlint: disable: identifier_name
public struct BaseTextFieldStyle: TextFieldStyle {
    @Environment(\.isEnabled) private var isEnabled

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textStyle(.body)
            .textFieldOverlay(isEnabled)
    }
}
