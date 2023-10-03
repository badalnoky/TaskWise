import Resolver
import SwiftUI

@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
        .modelContainer(for: [Task.self, CustomColumn.self, CustomCategory.self, CustomPriority.self])
    }
}
