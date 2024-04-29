import SwiftUI

struct TaskCell {
    var title: String
    var priority: String
    var category: String
    var categoryColor: Color

    init(title: String, priority: String, category: String, categoryColor: Color) {
        self.title = title
        self.priority = priority
        self.category = category
        self.categoryColor = categoryColor
    }
}

extension TaskCell: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .fill(categoryColor)
                .frame(width: .padding4, height: .watchCategoryColorHeight)
                .padding(.padding4)
            VStack {
                Text(title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Str.TaskItem.priority(priority))
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(category)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, .padding4)
        }
        .padding(.horizontal, .padding4)
        .frame(maxWidth: .infinity, alignment: .center)
        .overlay {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(.accent, lineWidth: .borderWidth)
        }
        .padding(.borderWidth)
        .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
        .padding(.borderWidth)
    }
}

#Preview {
    TaskCell(title: "Title", priority: "High", category: "category", categoryColor: .green)
}
