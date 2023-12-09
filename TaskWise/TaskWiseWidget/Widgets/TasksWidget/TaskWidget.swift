import SwiftUI
import WidgetKit

public struct TaskWidgetEntryView: View {
    var entry: TaskProvider.Entry

    var minTaskIndex: Int {
        entry.selectedPage * .taskWidgetMaxDisplayed
    }

    var maxTaskIndex: Int {
        if tasksForSelected.isEmpty {
            return .zero
        }
        let projectedMax = minTaskIndex.projectedMax
        return projectedMax >= tasksForSelected.count ? tasksForSelected.count.previous : projectedMax
    }

    var selectedColumn: TaskColumn.DTO {
        if entry.columns.isEmpty {
            return .placeholder
        }
        return entry.columns[entry.selectedIndex]
    }

    var tasksForSelected: [Task.WidgetDTO] {
        entry.tasks.filter { $0.columnId == selectedColumn.id }
    }

    var tasksViewed: [Task.WidgetDTO] {
        if tasksForSelected.isEmpty {
            return []
        }
        return Array(tasksForSelected[minTaskIndex...maxTaskIndex])
    }

    public var body: some View {
        VStack(spacing: .zero) {
            HStack {
                WidgetColumnButton(type: .previous, condition: entry.selectedIndex != .zero)
                TaskWidgetHeader(name: selectedColumn.name)
                    .transition(.push(from: .trailing))
                WidgetColumnButton(type: .next, condition: entry.selectedIndex != entry.columns.count.previous)
            }
            .padding(.bottom, .padding12)
            VStack(spacing: .zero) {
                WidgetPageButton(type: .up, condition: entry.selectedPage != .zero && !tasksViewed.isEmpty)
                VStack {
                    ForEach(tasksViewed, id: \.id) { task in
                        TaskItemView(
                            title: task.title,
                            priority: task.priority,
                            category: task.category,
                            categoryColor: task.categoryColor
                        )
                    }
                    .transition(.push(from: .bottom))
                    if tasksViewed.count < .taskWidgetMaxDisplayed {
                        TaskItemPlaceholder()
                    }
                    if tasksViewed.count == .one {
                        TaskItemPlaceholder()
                    }
                }
                .padding(.vertical, .padding12)
                .frame(maxHeight: .infinity, alignment: .center)
                WidgetPageButton(type: .down, condition: maxTaskIndex != tasksForSelected.count.previous && !tasksViewed.isEmpty)
            }
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
    TaskEntry.previewEntry(selectedIndex: .zero, selectedPage: .zero)
    TaskEntry.previewEntry(selectedIndex: .zero, selectedPage: 1)
    TaskEntry.previewEntry(selectedIndex: .zero, selectedPage: 2)
    TaskEntry.previewEntry(selectedIndex: 1, selectedPage: .zero)
    TaskEntry.previewEntry(selectedIndex: 1, selectedPage: 1)
    TaskEntry.previewEntry(selectedIndex: 1, selectedPage: 2)
    TaskEntry.previewEntry(selectedIndex: 2, selectedPage: .zero)
    TaskEntry.previewEntry(selectedIndex: 2, selectedPage: 1)
    TaskEntry.previewEntry(selectedIndex: 2, selectedPage: 2)
}
