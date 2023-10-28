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
        updateIndices(on: priorities)
        fetchPriorities()
    }

    func deletePriority(_ priority: Priority) {
        // TODO: delete, handle when it has tasks, or it is the last
        fetchPriorities()
    }

    private func updateIndices(on priorities: [Priority]) {
        for idx in priorities.indices {
            priorities[idx].wLevel = Int16(idx + 1)
        }
        save()
    }
}
