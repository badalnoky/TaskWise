import Foundation

struct TaskColumn: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var index: Int

    init(id: UUID = UUID(), name: String, index: Int) {
        self.id = id
        self.name = name
        self.index = index
    }
}
