import Combine
import SwiftUI

@Observable final class WatchDashboardViewModel {
    private var dataService: DataService
    private var cancellables = Set<AnyCancellable>()
    private var tasks: [TWTask] = []

    var selectedTab: Int = .zero
    var columns: [TaskColumn] = []

    var selectedColumn: Int = .zero

    var tasksForSelected: [TWTask] {
        guard !columns.isEmpty else { return [] }
        return tasks.from(column: columns[selectedColumn])
    }

    var selectedColumnName: String {
        guard !columns.isEmpty else { return .empty }
        return columns[selectedColumn].name
    }

    var doneCount: Int {
        guard let last = columns.last else { return .zero }
        return tasks.from(column: last).count
    }

    var totalCount: Int {
        tasks.count
    }

    init() {
        self.dataService = DataService(shouldLoadDefaults: false)
        addDemoData()
        registerBindings()
    }
}

extension WatchDashboardViewModel {
    func didTapNextColumn() {
        self.selectedColumn += .one
    }

    func didTapPreviousColumn() {
        self.selectedColumn -= .one
    }
}

private extension WatchDashboardViewModel {
    private func registerBindings() {
        registerTaskBinding()
        registerColumnBinding()
    }

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.todaysTasks
            .sink { [weak self] tasks in
                withAnimation(.smooth(duration: .defaultAnimationDuration)) {
                    self?.tasks = tasks
                }
            }
            .store(in: &cancellables)
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }
}

#if DEBUG
private extension WatchDashboardViewModel {
    // swiftlint: disable all
    func addDemoData() {
        if let isInitialized = UserDefaults.standard.value(forKey: "demoInit") as? Bool, isInitialized != true {
            let low = Priority(context: self.dataService.context)
            low.wId = UUID()
            low.wLevel = 1
            low.wName = "Low"

            let medium = Priority(context: self.dataService.context)
            medium.wId = UUID()
            medium.wLevel = 2
            medium.wName = "Medium"

            let high = Priority(context: self.dataService.context)
            high.wId = UUID()
            high.wLevel = 3
            high.wName = "High"

            let work = Category(context: self.dataService.context)
            work.wId = UUID()
            work.wName = "Work"
            work.wColorComponents = ColorComponents.create(from: .init(red: 0, green: 0, blue: 1, alpha: 1), on: self.dataService.context)

            let school = Category(context: self.dataService.context)
            school.wId = UUID()
            school.wName = "School"
            school.wColorComponents = ColorComponents.create(from: .init(red: 0, green: 1, blue: 1, alpha: 1), on: self.dataService.context)

            let health = Category(context: self.dataService.context)
            health.wId = UUID()
            health.wName = "Health"
            health.wColorComponents = ColorComponents.create(from: .init(red: 0, green: 1, blue: 0, alpha: 1), on: self.dataService.context)

            let freetime = Category(context: self.dataService.context)
            freetime.wId = UUID()
            freetime.wName = "Freetime"
            freetime.wColorComponents = ColorComponents.create(from: .init(red: 1, green: 0.7, blue: 0, alpha: 1), on: self.dataService.context)

            let other = Category(context: self.dataService.context)
            other.wId = UUID()
            other.wName = "Other"
            other.wColorComponents = ColorComponents.create(from: .init(red: 1, green: 0, blue: 1, alpha: 1), on: self.dataService.context)

            let todo = TaskColumn(context: self.dataService.context)
            todo.wId = UUID()
            todo.wIndex = 1
            todo.wName = "TODO"

            let inProgress = TaskColumn(context: self.dataService.context)
            inProgress.wId = UUID()
            inProgress.wIndex = 2
            inProgress.wName = "In Progress"

            let done = TaskColumn(context: self.dataService.context)
            done.wId = UUID()
            done.wIndex = 3
            done.wName = "Done"

            let t1 = TWTask(context: self.dataService.context)
            t1.wId = UUID()
            t1.wTitle = "Make presentation"
            t1.wTaskDescription = "For university"
            t1.wColumn = done
            t1.wDate = .now
            t1.wStartDateTime = .now
            t1.wEndDateTime = .now
            t1.wCategory = school
            t1.wPriority = high
            t1.wHasTimeConstraints = false

            let s1 = TaskStep(context: self.dataService.context)
            s1.wLabel = "Record demo"
            s1.wIndex = 0
            s1.wIsDone = true
            s1.wTask = t1

            let s2 = TaskStep(context: self.dataService.context)
            s2.wLabel = "Make ppt"
            s2.wIndex = 1
            s2.wIsDone = false
            s2.wTask = t1

            let t2 = TWTask(context: self.dataService.context)
            t2.wId = UUID()
            t2.wTitle = "Work"
            t2.wTaskDescription = "Home office"
            t2.wColumn = todo
            t2.wDate = .now
            t2.wStartDateTime = .now
            t2.wEndDateTime = .now
            t2.wCategory = work
            t2.wPriority = medium
            t2.wHasTimeConstraints = false

            let t3 = TWTask(context: self.dataService.context)
            t3.wId = UUID()
            t3.wTitle = "Go to the gym"
            t3.wTaskDescription = ""
            t3.wColumn = todo
            t3.wDate = .now
            t3.wStartDateTime = .now
            t3.wEndDateTime = .now
            t3.wCategory = health
            t3.wPriority = high
            t3.wHasTimeConstraints = false

            dataService.save()

            UserDefaults.standard.setValue(true, forKey: "demoInit")
        }
//        UserDefaults.standard.setValue(false, forKey: "demoInit")
    }
}
#endif
