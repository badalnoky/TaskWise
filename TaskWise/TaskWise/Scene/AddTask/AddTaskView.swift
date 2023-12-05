import SwiftUI

struct AddTaskView {
    @Bindable var viewModel: AddTaskViewModel
}

extension AddTaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding12) {
                StyledField(style: .title, title: Str.taskTitleLabel, text: $viewModel.title)

                StyledField(style: .description, title: Str.taskDescriptionLabel, text: $viewModel.description)

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

                TaskRow(title: Str.taskStartingColumnLabel, selected: $viewModel.selectedColumn) {
                    ForEach(viewModel.columns, id: \.self) {
                        Text($0.name).tag($0)
                    }
                }

                CombinedDatePicker(allDay: $viewModel.allDay, starts: $viewModel.starts, ends: $viewModel.ends)

                stepView

                Button(Str.taskCreateButtonLabel, action: viewModel.didTapCreate)
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
            StyledText(text: Str.taskStepsLabel, style: .base)

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
                StyledField(style: .base, title: Str.taskStepLabel, text: $viewModel.newStepName)
                IconButton(.add, action: viewModel.didTapAddStep)
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: .mock)
}
