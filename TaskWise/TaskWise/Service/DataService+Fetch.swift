extension DataService {
    func fetchTasks() {
        guard let tasks = try? context.fetch(Task.fetchRequest()) else { return }
        self.tasks.send(tasks)
    }

    func fetchPriorities() {
        guard let priorities = try? context.fetch(Priority.fetchRequest()) else { return }
        self.priorities.send(priorities)
    }

    func fetchCategories() {
        guard let categories = try? context.fetch(Category.fetchRequest()) else { return }
        self.categories.send(categories)
    }

    func fetchColumns() {
        guard let columns = try? context.fetch(TaskColumn.fetchRequest()) else { return }
        self.columns.send(columns)
    }

    func fetchSteps(for task: Task) {
        guard let steps = try? context.fetch(TaskStep.fetchRequest(for: task)) else { return }
        self.currentSteps.send(steps)
    }
}
