import SwiftUI

public final class ContentSceneFactory: SceneFactory {
    public init() {}

    @ViewBuilder
    public func view(for screen: ContentScreen, with navigator: Navigator<ContentSceneFactory>) -> some View {
        switch screen {
        case .addTask: addTask(with: navigator)
        case .calendar: calendar(with: navigator)
        case .dashboard: dashboard(with: navigator)
        case .day: day(with: navigator)
        case .settings: settings(with: navigator)
        case .task: task(with: navigator)
        }
    }
}

extension ContentSceneFactory {
    func addTask(with navigator: Navigator<ContentSceneFactory>) -> AddTaskView {
        AddTaskView(viewModel: AddTaskViewModel(navigator: navigator))
    }
    func calendar(with navigator: Navigator<ContentSceneFactory>) -> CalendarView {
        CalendarView(viewModel: CalendarViewModel(navigator: navigator))
    }

    func dashboard(with navigator: Navigator<ContentSceneFactory>) -> DashboardView {
        DashboardView(viewModel: DashboardViewModel(navigator: navigator))
    }

    func day(with navigator: Navigator<ContentSceneFactory>) -> DayView {
        DayView(viewModel: DayViewModel(navigator: navigator))
    }

    func settings(with navigator: Navigator<ContentSceneFactory>) -> SettingsView {
        SettingsView(viewModel: SettingsViewModel(navigator: navigator))
    }

    func task(with navigator: Navigator<ContentSceneFactory>) -> TaskView {
        TaskView(viewModel: TaskViewModel(navigator: navigator))
    }
}
