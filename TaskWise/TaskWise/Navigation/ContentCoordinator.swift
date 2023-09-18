import Foundation

public final class ContentCoordinator: Coordinator<ContentSceneFactory>, ObservableObject {}

public extension Navigator where Factory == ContentSceneFactory {
    func showCalendar() {
        push(screen: .calendar)
    }

    func showDay() {
        push(screen: .day)
    }

    func showSettings() {
        push(screen: .settings)
    }

    func showTask() {
        push(screen: .task)
    }
}
