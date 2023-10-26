extension DataService {
    func addPriority(_ priority: Priority.DTO) {
        Priority.create(from: priority, on: context)
        save()
        fetchPriorities()
    }

    func updatePriorityName(on priority: Priority, to newName: String) {
        priority.wName = newName
        save()
        fetchPriorities()
    }

    func updateOrder(of priorities: [Priority]) {
        // TODO: update order
        save()
        fetchPriorities()
    }

    func deletePriority(_ priority: Priority) {
        // TODO: delete, handle when it has tasks, or it is the last
        fetchPriorities()
    }
}
