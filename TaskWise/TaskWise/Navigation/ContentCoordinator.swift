import Foundation

public final class ContentCoordinator: Coordinator<ContentSceneFactory>, ObservableObject {}

public extension Navigator where Factory == ContentSceneFactory {
    func showAddTask(with date: Date) {
        push(screen: .addTask(date))
    }

    func showCalendar() {
        push(screen: .calendar)
    }

    func showDay(_ date: Date) {
        push(screen: .day(date))
    }

    func showSettings() {
        push(screen: .settings)
    }

    func showTask(_ taskId: UUID) {
        push(screen: .task(taskId))
    }
}
