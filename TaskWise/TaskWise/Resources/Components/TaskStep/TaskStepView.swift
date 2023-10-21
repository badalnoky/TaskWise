import Resolver
import SwiftUI

public struct TaskStepView: View {
    @State private var step: TaskStep
    private var action: () -> Void

    public var body: some View {
        HStack {
            Group {
                if step.isDone {
                    Image(systemName: Str.iconsCheck)
                        .fittedToSize(.defaultCheckboxSize)
                } else {
                    Circle()
                        .stroke(lineWidth: .borderWidth)
                        .sized(.defaultCheckboxSize)
                }
            }
            .onTapGesture { action() }

            Text(step.label)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    public init(step: TaskStep, action: @escaping () -> Void) {
        self.step = step
        self.action = action
    }
}

#Preview {
    TaskStepView(step: .mock) { }
}
