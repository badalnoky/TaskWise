import WidgetKit

struct CompletionProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompletionEntry {
        CompletionEntry(date: .now, completedTasks: .one, totalTasks: .one.next.next)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompletionEntry) -> Void) {
        let entry: CompletionEntry

        if context.isPreview {
            entry = CompletionEntry(date: .now, completedTasks: .one, totalTasks: .one.next.next)
        } else {
            entry = CompletionEntry(date: .now, completedTasks: .zero, totalTasks: .zero)
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CompletionEntry>) -> Void) {
        // fetch data
        let entry = CompletionEntry(date: .now, completedTasks: .zero, totalTasks: .zero)
        // swiftlint: disable: force_unwrapping
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: .ten, to: .now)!
        // swiftlint: enable: force_unwrapping
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}
