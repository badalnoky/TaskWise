import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerNavigation()
    }
}
extension Resolver {
    public static func registerNavigation() {
        register {
            ContentCoordinator(root: .dashboard)
        }
    }
}
