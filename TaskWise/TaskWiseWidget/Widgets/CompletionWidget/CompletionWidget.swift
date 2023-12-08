import SwiftUI
import WidgetKit

public struct CompletionWidgetEntryView: View {
    var entry: CompletionProvider.Entry

    public var body: some View {
        TaskProgressWidgetIndicator(done: entry.completedTasks, total: entry.totalTasks)
    }
}

struct CompletionWidget: Widget {
    let kind: String = .completionWidgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompletionProvider()) { entry in
            if #available(iOS 17.0, *) {
                CompletionWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CompletionWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(String.completionWidgetConfigurationName)
        .description(String.completionWidgetDescription)
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    CompletionWidget()
} timeline: {
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 0)
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 1, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 2, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 3, totalTasks: 3)
}
