import SwiftUI

public protocol SceneFactory {
    associatedtype SpecificNavigator: NavigatorInput
    associatedtype FlowScreen: Screen
    associatedtype View: SwiftUI.View

    init()

    @ViewBuilder func view(for screen: FlowScreen, with navigator: SpecificNavigator) -> Self.View
}
