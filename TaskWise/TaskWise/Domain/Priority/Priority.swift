import Foundation

struct Priority: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var level: Int

    init(id: UUID = UUID(), name: String, level: Int) {
        self.id = UUID()
        self.name = name
        self.level = level
    }
}
