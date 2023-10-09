import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerNavigationLayer()
        registerServiceLayer()
    }
}
extension Resolver {
    public static func registerNavigationLayer() {
        register {
            ContentCoordinator(root: .dashboard)
        }
    }

    public static func registerServiceLayer() {
        register {
            DataController()
        }.scope(.application)
    }
}
