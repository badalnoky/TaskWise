import SwiftUI

struct AddTaskView {
    private typealias Txt = Str.Task
    @Bindable var viewModel: AddTaskViewModel
}

extension AddTaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
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

                TaskRow(title: Txt.startingColumnLabel, selected: $viewModel.selectedColumn) {
                    ForEach(viewModel.columns, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }

                CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)

                RepeatBehaviourPicker(startingDate: viewModel.starts, repeatBehaviour: $viewModel.repeatBehaviour)

                stepView

                Button(Txt.createButtonLabel, action: viewModel.didTapCreate)
                    .buttonStyle(BaseButtonStyle())
            }
        }
        .scrollIndicators(.never, axes: .vertical)
        .environment(\.editMode, $viewModel.editMode)
        .defaultViewPadding()
    }
}

extension AddTaskView {
    var stepView: some View {
        VStack(spacing: .padding12) {
            StyledText(text: Txt.stepsLabel, style: .base)
                .frame(height: .defaultRowHeight)
                .padding(.leading, .padding4)

            List {
                ForEach($viewModel.steps, id: \.self) { $step in
                    HStack {
                        StepIcon(isDone: step.isDone)
                            .onTapGesture {
                                withAnimation { viewModel.didTapToggle(on: step) }
                            }
                        TextField(String.empty, text: $step.label)
                            .textFieldOverlay()
                            .textStyle(.body)
                    }
                    .stepRowSettings()
                }
                .onDelete(perform: viewModel.didTapDeleteSteps)
                .onMove(perform: viewModel.didMoveStep)
                .defaultListRowSettings()
            }
            .defaultListSettings()

            HStack {
                StyledField(style: .base, title: Txt.stepLabel, text: $viewModel.newStepName)
                IconButton(.add, action: viewModel.didTapAddStep)
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: .mock)
}
