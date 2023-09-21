import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Circle()
                .stroke(lineWidth: .borderWidth)
                .sized(.defaultCheckboxSize)
                .overlay {
                    Image(systemName: configuration.isOn ? Str.iconsCheck : "")
                        .fittedToSize(.defaultCheckboxSize)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        configuration.isOn.toggle()
                    }
                }

            configuration.label
        }
    }
}
