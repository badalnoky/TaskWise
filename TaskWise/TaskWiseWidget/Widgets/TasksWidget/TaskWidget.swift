import SwiftUI
import WidgetKit

public struct TaskWidgetEntryView: View {
    var entry: TaskProvider.Entry

    var selectedIndex: Int = 0
    var selectedPage: Int = 0
    var minTaskIndex: Int {
        selectedPage * 3
    }

    var maxTaskIndex: Int {
        let projectedMax = minTaskIndex + 2
        return projectedMax >= tasksForSelected.count ? tasksForSelected.count.previous : projectedMax
    }

    var selectedColumn: TaskColumn.DTO {
        entry.columns[selectedIndex]
    }

    var tasksForSelected: [Task.WidgetDTO] {
        entry.tasks.filter { $0.columnId == selectedColumn.id }
    }

    var tasksViewed: [Task.WidgetDTO] {
        Array(tasksForSelected[minTaskIndex...maxTaskIndex])
    }

    public var body: some View {
        VStack(spacing: .zero) {
            HStack {
                WidgetColumnButton(type: .previous, condition: selectedIndex != 0)
                TaskWidgetHeader(name: selectedColumn.name)
                WidgetColumnButton(type: .next, condition: selectedIndex != entry.columns.count)
            }
            .padding(.bottom, .padding12)
            VStack(spacing: .zero) {
                WidgetPageButton(type: .up, condition: selectedPage != 0)
                VStack {
                    ForEach(tasksViewed, id: \.id) { task in
                        TaskItemView(
                            title: task.title,
                            priority: task.priority,
                            category: task.category,
                            categoryColor: task.categoryColor
                        )
                    }
                }
                .padding(.vertical, .padding12)
                WidgetPageButton(type: .down, condition: maxTaskIndex != tasksForSelected.count.previous)
            }
            Spacer()
        }
    }
}

struct TaskWidget: Widget {
    let kind: String = .taskWidgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TaskProvider()) { entry in
            if #available(iOS 17.0, *) {
                TaskWidgetEntryView(entry: entry)
                    .containerBackground(.widgetBackground, for: .widget)
            } else {
                TaskWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(String.taskWidgetConfigurationName)
        .description(String.taskWidgetDescription)
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    TaskWidget()
} timeline: {
    TaskEntry(
        date: .now,
        tasks: [
            .placeholder, .placeholder, .placeholder, .placeholder,
            .placeholder, .placeholder, .placeholder, .placeholder
        ],
        columns: [.placeholder, .placeholder, .placeholder]
    )
}
