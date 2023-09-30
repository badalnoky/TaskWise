struct Category: Codable, Hashable {
    let name: String

    init(name: String) {
        self.name = name
    }
}
