import SwiftUI

struct TaskDetailView {
    @Bindable var viewModel: TaskDetailViewModel

    init(task: Task) {
        self.viewModel = TaskDetailViewModel(task: task)
    }
}

// swiftlint: disable: closure_body_length
extension TaskDetailView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .padding8) {
                Text(viewModel.title)
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                WatchRow(label: Str.Task.priorityLabel, value: viewModel.priority)
                WatchRow(label: Str.Task.categoryLabel, value: viewModel.category)
                if !viewModel.allDay {
                    WatchRow(label: Str.Task.startsLabel, date: viewModel.startDateTime)
                    WatchRow(label: Str.Task.endsLabel, date: viewModel.endDateTime)
                } else {
                    WatchRow(label: Str.Task.startsLabel, value: Str.DatePicker.allDayLabel)
                }
                Text(Str.Task.stepsLabel + .colon)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(viewModel.steps) { step in
                    HStack {
                        Group {
                            if step.isDone {
                                Image.check
                                    .fittedToSize(.watchStepIndicatorSize)
                                    .foregroundStyle(Color.stepCheck)
                            } else {
                                Circle()
                                    .stroke(lineWidth: .borderWidth)
                                    .frame(
                                        width: .watchStepIndicatorSize - .borderWidth,
                                        height: .watchStepIndicatorSize - .borderWidth
                                    )
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                        .padding(.borderWidth)

                        Text(step.label)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .padding()
        .containerBackground(Color.from(components: viewModel.task.category.colorComponents).gradient, for: .navigation)
    }
}

#Preview {
    TaskDetailView(task: .mock)
}
