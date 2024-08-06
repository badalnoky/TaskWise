import Resolver
import SwiftUI

@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            } else {
                coordinator.start()
            }
            #elseif os(macOS)
            #endif
        }
    }
}
