import Dispatch

extension DispatchTime {
    static var defaultDelayed: DispatchTime {
        .now() + 0.5
    }
}

extension DispatchQueue {
    static func delayed(_ action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .defaultDelayed) {
            action()
        }
    }
}
