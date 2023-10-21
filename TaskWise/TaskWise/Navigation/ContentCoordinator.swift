import Foundation

public final class ContentCoordinator: Coordinator<ContentSceneFactory>, ObservableObject {}

public extension Navigator where Factory == ContentSceneFactory {
    func showAddTask() {
        push(screen: .addTask)
    }

    func showCalendar() {
        push(screen: .calendar)
    }

    func showDay() {
        push(screen: .day)
    }

    func showSettings() {
        push(screen: .settings)
    }

    func showTask(_ taskId: UUID) {
        push(screen: .task(taskId))
    }
}
