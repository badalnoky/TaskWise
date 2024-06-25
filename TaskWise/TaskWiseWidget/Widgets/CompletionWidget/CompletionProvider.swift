import SwiftUI
import WidgetKit

struct CompletionProvider: TimelineProvider {
    let service = DataService(shouldLoadDefaults: false)

    func placeholder(in context: Context) -> CompletionEntry {
        CompletionEntry(date: .now, completedTasks: .one, totalTasks: .one.next.next)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompletionEntry) -> Void) {
        if context.isPreview {
            completion(CompletionEntry(date: .now, completedTasks: .one, totalTasks: .one.next.next))
        } else {
            Task {
                do {
                    let tuple = try await service.fetchCompletion()
                    let entry = CompletionEntry(date: .now, completedTasks: tuple.0, totalTasks: tuple.1)
                    completion(entry)
                } catch {
                    print(error.localizedDescription)
                    let entry = CompletionEntry(date: .now, completedTasks: .zero, totalTasks: .zero)
                    completion(entry)
                }
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CompletionEntry>) -> Void) {
        // swiftlint: disable force_unwrapping
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: .ten, to: .now)!
        // swiftlint: enable force_unwrapping
        Task {
            do {
                let tuple = try await service.fetchCompletion()
                let entry = CompletionEntry(date: .now, completedTasks: tuple.0, totalTasks: tuple.1)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let entry = CompletionEntry(date: .now, completedTasks: .zero, totalTasks: .zero)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
                completion(timeline)
            }
        }
    }
}
