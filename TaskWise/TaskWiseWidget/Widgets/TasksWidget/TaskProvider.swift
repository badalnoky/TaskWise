import SwiftUI
import WidgetKit

struct TaskProvider: TimelineProvider {
    let service = DataService(shouldLoadDefaults: false)

    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: .now, tasks: [.placeholder], columns: [.placeholder])
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> Void) {
        if context.isPreview {
            completion(TaskEntry(date: .now, tasks: [.placeholder], columns: [.placeholder]))
        } else {
            SwiftUI.Task {
                do {
                    let tuple = try await service.fetchToday()
                    let entry = TaskEntry(date: .now, tasks: tuple.0, columns: tuple.1)
                    completion(entry)
                } catch {
                    print(error.localizedDescription)
                    let entry = TaskEntry(date: .now, tasks: [], columns: [])
                    completion(entry)
                }
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> Void) {
        // swiftlint: disable: force_unwrapping
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: .ten, to: .now)!
        // swiftlint: enable: force_unwrapping
        SwiftUI.Task {
            do {
                let tuple = try await service.fetchToday()
                let entry = TaskEntry(date: .now, tasks: tuple.0, columns: tuple.1)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let entry = TaskEntry(date: .now, tasks: [], columns: [])
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            }
        }
    }
}
