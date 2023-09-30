struct Priority: Codable, Hashable {
    let name: String
    let level: Int

    init(name: String, level: Int) {
        self.name = name
        self.level = level
    }
}
