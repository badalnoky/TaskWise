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
            SwiftUI.Task {
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
        SwiftUI.Task {
            do {
                let tuple = try await service.fetchCompletion()
                let entry = CompletionEntry(date: .now, completedTasks: tuple.0, totalTasks: tuple.1)
                let timeline = Timeline(entries: [entry], policy: .never)
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let entry = CompletionEntry(date: .now, completedTasks: .zero, totalTasks: .zero)
                let timeline = Timeline(entries: [entry], policy: .never)
                completion(timeline)
            }
        }
    }
}
