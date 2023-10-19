import SwiftUI

struct TaskView {
    @Bindable var viewModel: TaskViewModel
}
// swiftlint: disable: closure_body_length
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
                            Text($0.name).tag($0)
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

                HStack {
                    Text("Starting column")
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedColumn) {
                        ForEach(viewModel.columns, id: \.self) {
                            Text($0.name)
                        }
                    }
                }

                Toggle(isOn: $viewModel.allDay.animation(.easeInOut)) {
                    Text("All-day")
                }

                if !viewModel.allDay {
                    DatePicker(selection: $viewModel.starts) {
                        Text(Str.taskStartsLabel)
                    }

                    DatePicker(selection: $viewModel.ends, displayedComponents: .hourAndMinute) {
                        Text(Str.taskEndsLabel)
                    }
                } else {
                    DatePicker(selection: $viewModel.starts, displayedComponents: .date) {
                        Text("Date")
                    }
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
                        // TODO: Resolve this
//                        let step = viewModel.steps[idx]
//                        HStack {
//                            Toggle(isOn: $viewModel.stepIsCompleted[idx]) {
//                                Text(viewModel.steps[idx])
//                            }
//                            .toggleStyle(CheckboxToggleStyle())
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical, .padding4)
                    }
                }
                .frame(height: 200)

                Button(
                    viewModel.isEditable ? Str.taskSaveButton : Str.taskDeleteButton,
                    action: viewModel.didTapAction
                )
                    .buttonStyle(.borderedProminent)
            }
        }
        .alert("Do you want to delete this task?", isPresented: $viewModel.isAlertVisible) {
            Button("Yes", role: .destructive, action: viewModel.didTapDelete)
            Button("No", role: .cancel) {}
        }
    }
}

#Preview {
    TaskView(viewModel: .mock)
}
