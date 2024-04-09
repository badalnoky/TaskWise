extension DataService {
    func createTasks(from task: Task.DTO, with behaviour: RepeatBehaviour) {
        if behaviour.frequency == .never {
            addTask(task)
        } else {
            RepeatingTasks.create(from: task, with: behaviour, on: context)
            save()
            fetchRepeatingTasks()
            handleWidgetCompletion(taskDate: task.date)
            handleWidgetTask(taskDate: task.date)
        }
    }

    func deleteRepeatingTasks() {
    }

    func deleteTaskFromRepeatingTasks() {
    }

    func updateRepeatingTasks() {
    }
}
