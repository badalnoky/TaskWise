import SwiftUI

struct TaskCell: View {
    var task: String
    var body: some View {
        Text(task)
    }
}

#Preview {
    TaskCell(task: "Task")
}
