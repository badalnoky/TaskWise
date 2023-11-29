import SwiftUI

public struct StepIcon {
    private var isDone: Bool

    public init(isDone: Bool) {
        self.isDone = isDone
    }
}

extension StepIcon: View {
    public var body: some View {
        Group {
            if isDone {
                Image(systemName: Str.iconsCheck)
                    .fittedToSize(.defaultCheckboxSize)
            } else {
                Circle()
                    .stroke(lineWidth: .borderWidth)
                    .sized(.defaultCheckboxSize)
            }
        }
    }
}

#Preview {
    StepIcon(isDone: false)
}
