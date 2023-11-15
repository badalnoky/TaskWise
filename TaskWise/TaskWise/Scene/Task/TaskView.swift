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
                    .textFieldStyle(.roundedBorder)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField(String.empty, text: $viewModel.description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
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
                            Text($0.name).tag($0)
                        }
                    }
                }

                HStack {
                    Text("Current column")
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedColumn) {
                        ForEach(viewModel.columns, id: \.self) {
                            Text($0.name).tag($0)
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

//                HStack {
//                    Text(Str.taskRepeatLabel)
//                    Spacer()
//                    Picker(String.empty, selection: $viewModel.selectedRepeats) {
//                        ForEach(viewModel.repeats, id: \.self) {
//                            Text($0).tag($0)
//                        }
//                    }
//                }

                Text(Str.taskStepsLabel)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                }
                .listStyle(.plain)
                .frame(height: 200)

                if viewModel.isEditable {
                    HStack {
                        TextField(String.empty, text: $viewModel.newStepName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textFieldStyle(.roundedBorder)
                        IconButton(.add, action: viewModel.didTapAddStep)
                    }
                }

                Button(viewModel.actionButtonLabel, action: viewModel.didTapAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .environment(\.editMode, $viewModel.editMode)
        .alert("Do you want to delete this task?", isPresented: $viewModel.isAlertVisible) {
            Button("Yes", role: .destructive, action: viewModel.didTapDelete)
            Button("No", role: .cancel) {}
        }
    }
}

#Preview {
    TaskView(viewModel: .mock)
}
