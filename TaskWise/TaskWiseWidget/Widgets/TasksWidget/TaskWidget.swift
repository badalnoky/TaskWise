import SwiftUI
import WidgetKit

public struct TaskWidgetEntryView: View {
    var entry: TaskProvider.Entry

    public var body: some View {
        Text("jello")
    }
}

struct TaskWidget: Widget {
    let kind: String = .taskWidgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TaskProvider()) { entry in
            if #available(iOS 17.0, *) {
                TaskWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TaskWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName(String.taskWidgetConfigurationName)
        .description(String.taskWidgetDescription)
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    TaskWidget()
} timeline: {
    TaskEntry(date: .now, tasks: [])
}
