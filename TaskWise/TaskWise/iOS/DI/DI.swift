import Resolver

extension Resolver: @retroactive ResolverRegistering {
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
            DataService()
        }
        .implements(DataServiceInput.self)
        .scope(.application)
    }
}
