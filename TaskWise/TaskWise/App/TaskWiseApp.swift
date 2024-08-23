import Resolver
import SwiftUI

@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            // MARK: iPhone
            #if os(iOS)
            if UIScreen.main.traitCollection.userInterfaceIdiom != .pad {
                coordinator.start()
            }

            // MARK: iPad
            if  UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
                PadNavigator()
            }

            // MARK: Mac
            #elseif os(macOS)
            MacDashboardView()
            #endif
        }
    }
}
