import AppIntents

struct ColumnIntent: AppIntent {
    static var title: LocalizedStringResource = "Page on the TaskWise widget"
    static var description = IntentDescription("Change the page on the current column")

    @Parameter(title: "Direction")
    var direction: Int

    init() {}

    init(direction: Int) {
        self.direction = direction
    }

    func perform() async throws -> some IntentResult {
        WidgetTimelineService.changeColumnIn(direction: direction)
        return .result()
    }
}
