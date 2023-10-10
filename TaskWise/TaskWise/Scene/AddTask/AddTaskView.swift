import SwiftUI

struct AddTaskView {
    @Bindable var viewModel: AddTaskViewModel
}
// swiftlint: disable: closure_body_length
extension AddTaskView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding16) {
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

                Toggle(isOn: $viewModel.allDay.animation(.easeInOut)) {
                    Text("All-day")
                }

                if !viewModel.allDay {
                    DatePicker(selection: $viewModel.starts, in: Date.now...) {
                        Text(Str.taskStartsLabel)
                    }

                    DatePicker(selection: $viewModel.ends, in: Date.now.addingTimeInterval(.hour)..., displayedComponents: .hourAndMinute) {
                        Text(Str.taskEndsLabel)
                    }
                } else {
                    DatePicker(selection: $viewModel.starts, in: Date.now..., displayedComponents: .date) {
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
                        let step = viewModel.steps[idx]
                        // TODO: Resolve this
//                        HStack {
//                            Toggle(isOn: $viewModel.steps[idx].isDone) {
//                                Text(step.label)
//                            }
//                            .toggleStyle(CheckboxToggleStyle())
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical, .padding4)
                    }
                }
                .frame(height: 200)

                ColorPicker(Str.taskColorLabel, selection: $viewModel.color)

                Button("create", action: viewModel.didTapCreate)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: .mock)
}
