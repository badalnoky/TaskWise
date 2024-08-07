import SwiftUI

struct TaskView {
    private typealias Txt = Str.Task

    @Bindable var viewModel: TaskViewModel
}

extension TaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
                Group {
                    StyledField(style: .title, title: Txt.titleLabel, text: $viewModel.title)

                    StyledField(style: .description, title: Txt.descriptionLabel, text: $viewModel.description)

                    TaskRow(title: Txt.priorityLabel, selected: $viewModel.selectedPriority) {
                        ForEach(viewModel.priorities, id: \.level) {
                            Text($0.name).tag($0)
                        }
                    }

                    TaskRow(title: Txt.categoryLabel, selected: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) {
                            Text($0.name).tag($0)
                        }
                    }

                    TaskRow(title: Txt.currentColumnLabel, selected: $viewModel.selectedColumn) {
                        ForEach(viewModel.columns, id: \.self) {
                            Text($0.name).tag($0)
                        }
                    }

                    CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)

                    RepeatBehaviourPicker(startingDate: viewModel.starts, repeatBehaviour: $viewModel.repeatBehaviour)
                }
                .disabled(!viewModel.isEditable)

                stepView

                Button(viewModel.actionButtonLabel, action: viewModel.didTapAction)
                    .buttonStyle(BaseButtonStyle())
            }
        }
        .scrollIndicators(.never, axes: .vertical)
        .defaultViewPadding()
        .environment(\.editMode, $viewModel.editMode)
        .alert(viewModel.deleteAlertMessage, isPresented: $viewModel.isDeleteAlertPresented) {
            if viewModel.isRepeating {
                Button(Str.Alert.deleteOnlyThis, role: .destructive, action: viewModel.didTapDelete)
                Button(Str.Alert.deleteAll, role: .destructive, action: viewModel.didTapDeleteRepeating)
                Button(Str.Alert.cancel, role: .cancel) {}
            } else {
                Button(Str.Alert.delete, role: .destructive, action: viewModel.didTapDelete)
                Button(Str.Alert.cancel, role: .cancel) {}
            }
        }
        .alert(Str.Alert.updateRepeating, isPresented: $viewModel.isUpdateAlertPresented) {
            Button(Str.Alert.updateAll, action: viewModel.didTapUpdateAll)
            Button(Str.Alert.updateOnlyThis, action: viewModel.didTapUpdateOnlyThis)
        }
        .taskNavigationBar(editAction: viewModel.didTapEdit)
    }
}

extension TaskView {
    var stepView: some View {
        VStack(spacing: .padding12) {
            StyledText(text: Txt.stepsLabel, style: .base)
                .frame(height: .defaultRowHeight)
                .padding(.leading, .padding4)

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
                    StyledField(style: .base, title: Txt.stepLabel, text: $viewModel.newStepName)
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
