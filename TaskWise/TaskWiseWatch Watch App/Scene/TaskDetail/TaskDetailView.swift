import SwiftUI

struct TaskDetailView {
    @Bindable var viewModel: TaskDetailViewModel

    init(task: Task) {
        self.viewModel = TaskDetailViewModel(task: task)
    }
}

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
                    Text(step.label)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
