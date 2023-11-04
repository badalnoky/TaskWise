#if DEBUG
extension TaskStep {
    static var mock: TaskStep {
        let step = TaskStep(context: PreviewDataService.global.context)
        step.wIndex = .zero
        step.wLabel = "Step"
        step.wIsDone = false
        step.wTask = .mock
        return step
    }
}
#endif
