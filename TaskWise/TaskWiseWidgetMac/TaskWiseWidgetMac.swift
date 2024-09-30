import SwiftUI
import WidgetKit

struct TaskWiseWidgetMac: Widget {
    let kind: String = .taskWidgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TaskProvider()) { entry in
            if #available(macOS 14.0, *) {
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
