import SwiftUI

public final class ContentSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: ContentScreen, with navigator: Navigator<ContentSceneFactory>) -> some View {
        switch screen {
        case .addTask(let date): addTask(with: navigator, date: date)
        case .calendar: calendar(with: navigator)
        case .dashboard: dashboard(with: navigator)
        case .day(let date): day(with: navigator, date: date)
        case .settings: settings(with: navigator)
        case .task(let id): task(with: navigator, taskId: id)
        }
    }
}

extension ContentSceneFactory {
    func addTask(with navigator: Navigator<ContentSceneFactory>, date: Date) -> AddTaskView {
        AddTaskView(viewModel: AddTaskViewModel(navigator: navigator, date: date))
    }
    func calendar(with navigator: Navigator<ContentSceneFactory>) -> CalendarView {
        CalendarView(viewModel: CalendarViewModel(navigator: navigator))
    }

    func dashboard(with navigator: Navigator<ContentSceneFactory>) -> PhoneDashboardView {
        PhoneDashboardView(viewModel: PhoneDashboardViewModel(navigator: navigator))
    }

    func day(with navigator: Navigator<ContentSceneFactory>, date: Date) -> DayView {
        DayView(viewModel: DayViewModel(navigator: navigator, date: date))
    }

    func settings(with navigator: Navigator<ContentSceneFactory>) -> SettingsView {
        SettingsView(viewModel: SettingsViewModel(navigator: navigator))
    }

    func task(with navigator: Navigator<ContentSceneFactory>, taskId: UUID) -> TaskView {
        TaskView(viewModel: TaskViewModel(navigator: navigator, taskId: taskId))
    }
}
