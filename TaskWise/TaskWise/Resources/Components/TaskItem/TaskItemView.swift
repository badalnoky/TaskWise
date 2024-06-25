import SwiftUI

struct TaskItemView {
    var title: String
    var priority: String
    var category: String
    var categoryColor: Color
}

extension TaskItemView: View {
    var body: some View {
        HStack {
            VStack {
                StyledText(text: title, style: .base)
                Text(Str.TaskItem.priority(priority))
                    .textStyle(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, .padding8)

            Text(category)
                .font(TextStyle.footnote.font)
                .contrastTo(color: categoryColor)
                .padding(.padding4)
                .background {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .fill(categoryColor)
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
    TaskItemView(title: .empty, priority: .empty, category: .empty, categoryColor: .red)
}
