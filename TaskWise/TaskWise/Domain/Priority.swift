import SwiftData

struct Priority: Codable, Hashable {
    let name: String
    let level: Int

    init(name: String, level: Int) {
        self.name = name
        self.level = level
    }
}

extension Priority {
    static var defaultPriorities: [Priority] {
        [
            Priority(name: "Low", level: 1),
            Priority(name: "Medium", level: 2),
            Priority(name: "High", level: 3)
        ]
    }
}

@Model final class CustomPriority {
    var priority = Priority.defaultPriorities[0]

    init(priority: Priority) {
        self.priority = priority
    }
}
