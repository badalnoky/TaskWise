import Resolver

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        registerServiceLayer()
    }
}
extension Resolver {
    public static func registerServiceLayer() {
        register {
            DataService()
        }
        .implements(DataServiceInput.self)
        .scope(.application)
    }
}
