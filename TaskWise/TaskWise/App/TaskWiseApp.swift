import Resolver
import SwiftUI

@main
struct TaskWiseApp: App {
    @StateObject var coordinator: ContentCoordinator = Resolver.resolve()
    var body: some Scene {
        WindowGroup {
            // MARK: iPhone
            if UIScreen.isPhone {
                coordinator.start()
            }

            // MARK: iPad
            if  UIScreen.isPad {
                PadNavigator()
            }
        }
    }
}
