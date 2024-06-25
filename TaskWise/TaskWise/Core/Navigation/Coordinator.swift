import Combine
import SwiftUI

// swiftlint: disable explicit_init

public protocol CoordinatorInput {
    associatedtype Factory: SceneFactory

    var isFlowFinished: PassthroughSubject<Bool, Never> { get }
    var cancellables: Set<AnyCancellable> { get }
    var navigator: Navigator<Factory> { get }

    init(root: Factory.FlowScreen)

    func registerBinding()
}

public extension CoordinatorInput {
    @ViewBuilder func start() -> some View { navigator }
}

open class Coordinator<Factory: SceneFactory>: CoordinatorInput {
    public var isFlowFinished = PassthroughSubject<Bool, Never>()
    public var cancellables = Set<AnyCancellable>()
    public var navigator: Navigator<Factory>

    public required init(root: Factory.FlowScreen) {
        self.navigator = Navigator(sceneFactory: Factory.init(), root: root)
        registerBinding()
    }

    public func registerBinding() {
        navigator.flowFinished.subscribe(isFlowFinished).store(in: &cancellables)
    }
}
