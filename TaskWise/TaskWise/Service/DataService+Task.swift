extension DataService {
    func addTask(_ task: Task.DTO) {
        Task.create(from: task, on: context)
        save()
        fetchTasks()
    }

    func updateTask(_ task: Task, with updated: Task.DTO) {
        task.update(with: updated, on: context)
        save()
        fetchTasks()
    }

    func updateColumn(to column: TaskColumn, on task: Task) {
        task.wColumn = column
        save()
        fetchTasks()
    }

    func addStepFrom(dto: TaskStep.DTO, to task: Task) {
        TaskStep.create(for: task, from: dto, on: context)
        save()
        fetchSteps(for: task)
    }

    func toggleIsDone(on step: TaskStep, for task: Task) {
        step.wIsDone.toggle()
        save()
        fetchSteps(for: task)
    }

    func updateStepLabel(on step: TaskStep, to newLabel: String) {
        step.wLabel = newLabel
        save()
    }

    func updateOrder(of steps: [TaskStep], on task: Task) {
        updateIndices(on: steps)
        fetchSteps(for: task)
    }

    private func updateIndices(on steps: [TaskStep]) {
        for idx in steps.indices {
            steps[idx].wIndex = Int16(idx)
        }
        save()
    }

    func delete(step deleted: TaskStep, from task: Task) {
        let updatedSteps = task.steps.filter { $0.index != deleted.index }
        delete(item: deleted)
        updateIndices(on: updatedSteps)
        fetchSteps(for: task)
    }

    func deleteTask(_ task: Task) {
        delete(item: task)
        fetchTasks()
    }
}
