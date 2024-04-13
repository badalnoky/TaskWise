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

    func deleteRepeatingTasks(_ repeating: RepeatingTasks) {
        delete(item: repeating)
        fetchTasks()
        fetchRepeatingTasks()
    }

    func deleteTaskFromRepeatingTasks() {
    }

    func updateRepeatingTasks() {
    }
}
