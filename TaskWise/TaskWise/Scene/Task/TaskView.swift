import SwiftUI

struct TaskView {
    @Bindable var viewModel: TaskViewModel
}

extension TaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
                Group {
                    StyledField(style: .title, title: "Title", text: $viewModel.title)

                    StyledField(style: .description, title: "Description", text: $viewModel.description)

                    TaskRow(title: Str.taskPriorityLabel, selected: $viewModel.selectedPriority) {
                        ForEach(viewModel.priorities, id: \.level) {
                            Text($0.name).tag($0)
                        }
                    }

                    TaskRow(title: Str.taskCategoryLabel, selected: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) {
                            Text($0.name).tag($0)
                        }
                    }

                    TaskRow(title: "Current column", selected: $viewModel.selectedColumn) {
                        ForEach(viewModel.columns, id: \.self) {
                            Text($0.name).tag($0)
                        }
                    }

                    CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)
                }
                .disabled(!viewModel.isEditable)

                stepView

                Button(viewModel.actionButtonLabel, action: viewModel.didTapAction)
                    .buttonStyle(BaseButtonStyle())
            }
        }
        .defaultViewPadding()
        .environment(\.editMode, $viewModel.editMode)
        .alert("Do you want to delete this task?", isPresented: $viewModel.isAlertVisible) {
            Button("Yes", role: .destructive, action: viewModel.didTapDelete)
            Button("No", role: .cancel) {}
        }
        .taskNavigationBar(editAction: viewModel.didTapEdit)
    }
}

extension TaskView {
    var stepView: some View {
        VStack(spacing: .padding12) {
            StyledText(text: Str.taskStepsLabel, style: .base)

            List {
                ForEach(viewModel.steps, id: \.self) { step in
                    TaskStepView(
                        step: step,
                        isEditable: viewModel.isEditable,
                        toggleAction: {
                            viewModel.didTapToggle(on: step)
                        },
                        newLabelAcion: {
                            viewModel.didChangeLabel(on: step, to: $0)
                        }
                    )
                }
                .onDelete(perform: viewModel.didTapDeleteSteps)
                .onMove(perform: viewModel.didMoveStep)
                .defaultListRowSettings()
            }
            .defaultListSettings()

            if viewModel.isEditable {
                HStack {
                    StyledField(style: .base, title: "Step", text: $viewModel.newStepName)
                    IconButton(.add, action: viewModel.didTapAddStep)
                }
            }
        }
        .padding(.horizontal, .padding4)
    }
}

#Preview {
    TaskView(viewModel: .mock)
}
