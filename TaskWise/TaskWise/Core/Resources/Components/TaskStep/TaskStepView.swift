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
            .contentShape(Circle())
            .onTapGesture {
                withAnimation {
                    toggleAction()
                }
            }

            TextField(
                String.empty,
                text: $stepLabel,
                onEditingChanged: { if !$0 { handleChange() } },
                onCommit: handleChange
            )
            .textFieldStyle(BaseTextFieldStyle())
            .disabled(!isEditable)
        }
        .padding(.horizontal, .padding4)
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
