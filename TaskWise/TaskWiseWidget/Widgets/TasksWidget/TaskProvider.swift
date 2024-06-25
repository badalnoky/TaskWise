import SwiftUI
import WidgetKit

struct TaskProvider: TimelineProvider {
    let service = DataService(shouldLoadDefaults: false)

    func placeholder(in context: Context) -> TaskEntry {
        .placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> Void) {
        if context.isPreview {
            completion(.placeholder)
        } else {
            Task {
                do {
                    let entry = try await service.fetchToday()
                    completion(entry)
                } catch {
                    print(error.localizedDescription)
                    completion(.empty)
                }
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> Void) {
        // swiftlint: disable force_unwrapping
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: .ten, to: .now)!
        // swiftlint: enable force_unwrapping
        Task {
            do {
                let entry = try await service.fetchToday()
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let timeline = Timeline(entries: [TaskEntry.empty], policy: .after(nextUpdateDate))
                completion(timeline)
            }
        }
    }
}
