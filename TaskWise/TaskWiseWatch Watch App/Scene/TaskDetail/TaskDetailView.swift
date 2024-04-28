import SwiftUI

struct TaskDetailView {
    var viewModel: TaskDetailViewModel

    init(task: Task) {
        self.viewModel = TaskDetailViewModel(task: task)
    }
}

extension TaskDetailView: View {
    var body: some View {
        Text("Task Details")
    }
}

#Preview {
    TaskDetailView(task: .mock)
}
