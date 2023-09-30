struct TaskStep: Codable {
    var isDone: Bool
    var label: String

    init(isDone: Bool, label: String) {
        self.isDone = isDone
        self.label = label
    }
}
