import SwiftUI

struct TaskItemView {
    var task: Task

    init(task: Task) {
        self.task = task
    }
}

extension TaskItemView: View {
    var body: some View {
        HStack {
            VStack {
                StyledText(text: task.title, style: .base)
                Text("\(task.priority.name) priority")
                    .textStyle(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, .padding8)

            Text(task.category.name)
                .font(TextStyle.footnote.font)
                .contrastTo(colorComponents: task.category.colorComponents)
                .padding(.padding4)
                .background {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .fill(Color.from(components: task.category.colorComponents))
                }
        }
        .padding(.horizontal, .padding8)
        .frame(maxWidth: .infinity, alignment: .center)
        .overlay {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(.accent, lineWidth: .borderWidth)
        }
        .padding(.borderWidth)
        .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
}

#Preview {
    TaskItemView(task: .mock)
}
