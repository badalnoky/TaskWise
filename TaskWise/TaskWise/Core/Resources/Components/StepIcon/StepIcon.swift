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
                Image.check
                    .fittedToSize(.defaultCheckboxSize)
                    .foregroundStyle(Color.stepCheck)
            } else {
                Circle()
                    .stroke(lineWidth: .borderWidth)
                    .sized(.defaultCheckboxSize)
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

#Preview {
    StepIcon(isDone: false)
}
