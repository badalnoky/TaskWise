import SwiftUI
import WidgetKit

struct TaskProvider: TimelineProvider {
    let service = DataService(shouldLoadDefaults: false)

    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: .now, tasks: [.placeholder])
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> Void) {
        if context.isPreview {
            completion(TaskEntry(date: .now, tasks: [.placeholder]))
        } else {
            SwiftUI.Task {
                do {
                    let tasks = try await service.fetchToday()
                    let entry = TaskEntry(date: .now, tasks: tasks)
                    completion(entry)
                } catch {
                    print(error.localizedDescription)
                    let entry = TaskEntry(date: .now, tasks: [])
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
                let tasks = try await service.fetchToday()
                let entry = TaskEntry(date: .now, tasks: tasks)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let entry = TaskEntry(date: .now, tasks: [])
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            }
        }
    }
}
