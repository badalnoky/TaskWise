import Resolver
import SwiftUI

@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            // MARK: iPhone
            #if os(iOS)
            if UIScreen.isPhone {
                coordinator.start()
            }

            // MARK: iPad
            if  UIScreen.isPad {
                PadNavigator()
            }

            // MARK: Mac
            #elseif os(macOS)
            MacDashboardView()
            #endif
        }
    }
}
