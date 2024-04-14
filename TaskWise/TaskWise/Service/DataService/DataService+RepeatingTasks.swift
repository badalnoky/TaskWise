extension DataService {
    func createTasks(from task: Task.DTO, with behaviour: RepeatBehaviour) {
        if behaviour.frequency == .never {
            addTask(task)
        } else {
            RepeatingTasks.create(from: task, with: behaviour, on: context)
            save()
            fetchTasks()
            fetchRepeatingTasks()
            handleWidgetCompletion(taskDate: task.date)
            handleWidgetTask(taskDate: task.date)
        }
    }

    func createTasks(from updated: Task.DTO, with behaviour: RepeatBehaviour, including task: Task) {
        updateTask(task, with: updated)
        RepeatingTasks.create(with: behaviour, including: task, on: context)
        save()
        fetchTasks()
        fetchRepeatingTasks()
    }

    func deleteRepeatingTasks(_ repeating: RepeatingTasks) {
        delete(item: repeating)
        fetchTasks()
        fetchRepeatingTasks()
    }

    func updateRepeatingTasks(_ repeating: RepeatingTasks, from dto: Task.DTO) {
        for task in repeating.tasks {
            task.updateRepeating(with: dto, on: context)
        }
        save()
        fetchTasks()
    }

    func updateStepLabelForRepeating(_ repeating: RepeatingTasks, on step: TaskStep, to newLabel: String) {
        for task in repeating.tasks {
            if let updated = task.steps.first(where: { taskStep in taskStep.index == step.index}) {
                updateStepLabel(on: updated, to: newLabel)
            }
        }
    }

    func deleteStepForRepeating(_ repeating: RepeatingTasks, step deleted: TaskStep) {
        for task in repeating.tasks {
            if let deleted = task.steps.first(where: { taskStep in taskStep.index == deleted.index}) {
                delete(step: deleted, from: task)
            }
        }
    }

    func updateStepOrderForRepeating(_ repeating: RepeatingTasks, to steps: [TaskStep]) {
        let updatedIndices = steps.map { $0.index }
        for task in repeating.tasks {
            var updated: [TaskStep] = []
            for index in updatedIndices {
                if let nextStep = task.steps.first(where: { taskStep in taskStep.index == index}) {
                    updated.append(nextStep)
                }
            }
            updateOrder(of: updated, on: task)
        }
    }

    func addStepToRepeating(_ repeating: RepeatingTasks, step: TaskStep.DTO) {
        for task in repeating.tasks {
            addStepFrom(dto: step, to: task)
        }
    }

    func rescheduleRepeatingTasks(_ repeatingTasks: RepeatingTasks, for behaviour: RepeatBehaviour, from task: Task.DTO) {
        deleteRepeatingTasks(repeatingTasks)
        createTasks(from: task, with: behaviour)
    }
}
