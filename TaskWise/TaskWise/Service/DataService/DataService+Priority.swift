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

    func updateOrder(priorities: [Priority]) {
        updateIndices(on: priorities)
        fetchPriorities()
    }

    func deletePriority(_ priority: Priority) {
        if priorities.value.count == .one {
            print("Return an error saying there needs to be at least one category")
        } else if (priority.wTasks?.count ?? .zero) > .zero {
            print("Return an error saying that some task use it")
        } else {
            let updatedPriorities = priorities.value.filter { $0.id != priority.id }
            delete(item: priority)
            updateIndices(on: updatedPriorities)
        }
        fetchPriorities()
    }

    private func updateIndices(on priorities: [Priority]) {
        for idx in priorities.indices {
            priorities[idx].wLevel = Int16(idx.next)
        }
        save()
    }
}
