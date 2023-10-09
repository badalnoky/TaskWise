import Resolver
import SwiftUI

// TODO: Clean up the whole code base
@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
