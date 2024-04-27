import SwiftUI

struct TaskDetailView {
    var viewModel: TaskDetailViewModel

    init(task: String) {
        self.viewModel = TaskDetailViewModel(task: task)
    }
}

extension TaskDetailView: View {
    var body: some View {
        Text("Task Details")
    }
}

#Preview {
    TaskDetailView(task: "Task")
}
