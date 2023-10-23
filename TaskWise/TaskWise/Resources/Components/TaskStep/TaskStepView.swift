import Resolver
import SwiftUI

public struct TaskStepView: View {
    @State private var step: TaskStep
    @State private var stepLabel: String
    private var isEditable: Bool
    private var toggleAction: () -> Void
    private var newLabelAcion: (String) -> Void

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
            .onTapGesture { toggleAction() }

            TextField(
                String.empty,
                text: $stepLabel,
                onEditingChanged: { if !$0 { handleChange() } },
                onCommit: handleChange
            )
            .textFieldStyle(.roundedBorder)
            .disabled(!isEditable)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    public init(
        step: TaskStep,
        isEditable: Bool,
        toggleAction: @escaping () -> Void,
        newLabelAcion: @escaping (String) -> Void
    ) {
        self.step = step
        self.stepLabel = step.label
        self.isEditable = isEditable
        self.toggleAction = toggleAction
        self.newLabelAcion = newLabelAcion
    }

    private func handleChange() {
        if stepLabel != step.label {
            newLabelAcion(stepLabel)
        }
    }
}

#Preview {
    TaskStepView(step: .mock, isEditable: false, toggleAction: {}, newLabelAcion: { _ in })
}
