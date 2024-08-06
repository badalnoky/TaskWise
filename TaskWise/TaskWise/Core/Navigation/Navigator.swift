import Combine
import SwiftUI

// swiftlint: disable force_cast

public protocol NavigatorInput: View {
    associatedtype Factory: SceneFactory

    var factory: Factory { get }
    var root: Factory.FlowScreen { get }

    func push(screen: Factory.FlowScreen)
    func pop()
    func finishFlow()
}

public struct Navigator<Factory: SceneFactory>: NavigatorInput {
    @State private var presentationStack = NavigationPath()

    public let factory: Factory
    public let root: Factory.FlowScreen
    public var flowFinished = CurrentValueSubject<Bool, Never>(false)

    public var body: some View {
        NavigationStack(path: $presentationStack) {
            factory.view(for: root, with: self as! Factory.SpecificNavigator)
                .navigationDestination(for: Factory.FlowScreen.self) { screen in
                    factory.view(for: screen, with: self as! Factory.SpecificNavigator)
                }
        }
    }

    public init(sceneFactory: Factory, root: Factory.FlowScreen) {
        self.factory = sceneFactory
        self.root = root
    }

    public func push(screen: Factory.FlowScreen) {
        presentationStack.append(screen)
    }

    public func pop() {
        if !presentationStack.isEmpty {
            presentationStack.removeLast()
        }
    }

    public func finishFlow() {
        flowFinished.send(true)
    }
}
