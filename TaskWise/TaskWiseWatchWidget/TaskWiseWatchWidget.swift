import SwiftUI
import WidgetKit

struct TaskWiseWatchWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: CompletionProvider.Entry

    var body: some View {
        switch family {
        case .accessoryCircular: CircularCompletionView(entry: entry)
        case .accessoryRectangular: RectangularCompletionView(entry: entry)
        case .accessoryCorner: CircularCompletionView(entry: entry)
        default: InlineCompletionView(entry: entry)
        }
    }
}

@main
struct TaskWiseWatchWidget: Widget {
    let kind: String = .watchWidgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompletionProvider()) { entry in
            if #available(watchOS 10.0, *) {
                TaskWiseWatchWidgetEntryView(entry: entry)
                    .containerBackground(.appTint.gradient, for: .widget)
            } else {
                TaskWiseWatchWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(String.watchWidgetConfigurationName)
        .description(String.watchWidgetDescription)
        .supportedFamilies(
            [.accessoryRectangular, .accessoryCorner, .accessoryCircular, .accessoryInline]
        )
    }
}

#Preview(as: .accessoryCircular) {
    TaskWiseWatchWidget()
} timeline: {
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 0)
    CompletionEntry(date: .now, completedTasks: 0, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 1, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 2, totalTasks: 3)
    CompletionEntry(date: .now, completedTasks: 3, totalTasks: 3)
}
