import Foundation
extension DataService {
    func addTask(_ task: TWTask.DTO) {
        TWTask.create(from: task, on: context)
        save()
        fetchTasks()
        handleWidgetCompletion(taskDate: task.date)
        handleWidgetTask(taskDate: task.date)
    }

    func updateTask(_ task: TWTask, with updated: TWTask.DTO) {
        task.update(with: updated, on: context)
        save()
        fetchTasks()
        handleWidgetCompletion(taskDate: task.date)
        handleWidgetCompletion(taskDate: updated.date)
        handleWidgetTask(taskDate: task.date)
        handleWidgetTask(taskDate: updated.date)
    }

    func updateColumn(to column: TaskColumn, on task: TWTask) {
        task.wColumn = column
        save()
        fetchTasks()
        handleWidgetCompletion(taskDate: task.date)
        handleWidgetTask(taskDate: task.date)
    }

    func addStepFrom(dto: TaskStep.DTO, to task: TWTask) {
        TaskStep.create(for: task, from: dto, on: context)
        save()
        fetchSteps(for: task)
    }

    func toggleIsDone(on step: TaskStep, for task: TWTask) {
        step.wIsDone.toggle()
        save()
        fetchSteps(for: task)
    }

    func updateStepLabel(on step: TaskStep, to newLabel: String) {
        step.wLabel = newLabel
        save()
    }

    func updateOrder(of steps: [TaskStep], on task: TWTask) {
        updateIndices(on: steps)
        fetchSteps(for: task)
    }

    private func updateIndices(on steps: [TaskStep]) {
        for idx in steps.indices {
            steps[idx].wIndex = Int16(idx)
        }
        save()
    }

    func delete(step deleted: TaskStep, from task: TWTask) {
        let updatedSteps = task.steps.filter { $0.index != deleted.index }
        delete(item: deleted)
        updateIndices(on: updatedSteps)
        fetchSteps(for: task)
    }

    func deleteTask(_ task: TWTask) {
        delete(item: task)
        fetchTasks()
        handleWidgetCompletion(taskDate: task.date)
        handleWidgetTask(taskDate: task.date)
    }
}
