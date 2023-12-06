import SwiftUI
import WidgetKit

public struct TaskWiseWidgetEntryView: View {
    var entry: CompletionProvider.Entry

    public var body: some View {
        TaskProgressWidgetIndicator(done: entry.completedTasks, total: entry.totalTasks)
    }
}

struct TaskWiseWidget: Widget {
    let kind: String = .widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompletionProvider()) { entry in
            if #available(iOS 17.0, *) {
                TaskWiseWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TaskWiseWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(String.widgetConfigurationName)
        .description(String.widgetDescription)
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    TaskWiseWidget()
} timeline: {
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 0)
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 1, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 2, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 3, totalTasks: 3)
}
