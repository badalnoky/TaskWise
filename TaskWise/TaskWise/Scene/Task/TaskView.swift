import SwiftUI

struct TaskView {
    @Bindable var viewModel: TaskViewModel
    @Environment(\.modelContext) private var context
}

extension TaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding16) {
                IconButton(.edit, action: viewModel.didTapEdit)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                TextField(String.empty, text: $viewModel.title)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField(String.empty, text: $viewModel.description, axis: .vertical)
                    .lineLimit(5)
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Text(Str.taskPriorityLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedPriority) {
                        ForEach(viewModel.priorities, id: \.level) {
                            Text($0.name)
                        }
                    }
                }

                HStack {
                    Text(Str.taskCategoryLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) {
                            Text($0.name)
                        }
                    }
                }

                DatePicker(selection: $viewModel.starts, in: Date.now...) {
                    Text(Str.taskStartsLabel)
                }

                DatePicker(selection: $viewModel.ends, in: Date.now.addingTimeInterval(.hour)...) {
                    Text(Str.taskEndsLabel)
                }

                HStack {
                    Text(Str.taskRepeatLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedRepeats) {
                        ForEach(viewModel.repeats, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Text(Str.taskStepsLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    ForEach(viewModel.steps.indices, id: \.self) { idx in
                        HStack {
                            Toggle(isOn: $viewModel.stepIsCompleted[idx]) {
                                Text(viewModel.steps[idx])
                            }
                            .toggleStyle(CheckboxToggleStyle())
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, .padding4)
                    }
                }
                .frame(height: 200)

                ColorPicker(Str.taskColorLabel, selection: $viewModel.color)

                Button(
                    viewModel.isEditable ? Str.taskSaveButton : Str.taskDeleteButton,
                    action: didTapAction
                )
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

extension TaskView {
    func didTapAction() {
        if viewModel.isEditable {
            let task = Task(
                title: viewModel.title,
                description: viewModel.description,
                priority: viewModel.selectedPriority,
                category: viewModel.selectedCategory,
                date: viewModel.starts,
                hasTimeConstraints: false,
                startDateTime: viewModel.starts,
                endDateTime: viewModel.ends,
                steps: [],
                colorComponents: viewModel.color.components
            )

            context.insert(task)
        }
    }
}

#Preview {
    TaskView(viewModel: .mock)
}
