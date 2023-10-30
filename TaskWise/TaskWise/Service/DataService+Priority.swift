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
        // TODO: Resolve this
        if priorities.value.count == 1 {
            print("return an error saying there needs to be at least one category")
        } else if (priority.wTasks?.count ?? 0) > 0 {
            print("return an error saying that some task use it")
        } else {
            let updatedPriorities = priorities.value.filter { $0.id != priority.id }
            delete(item: priority)
            updateIndices(on: updatedPriorities)
        }
        fetchPriorities()
    }

    private func updateIndices(on priorities: [Priority]) {
        for idx in priorities.indices {
            priorities[idx].wLevel = Int16(idx + 1)
        }
        save()
    }
}
