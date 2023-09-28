import Combine
import Network

public protocol NetworkMonitorServiceInput {
    var connectionState: CurrentValueSubject<Bool, Never> { get }
}

public final class NetworkMonitorService: ObservableObject, NetworkMonitorServiceInput {
    public static var shared: NetworkMonitorService = .init()

    private let queue = DispatchQueue(label: .networkQueueLabel)
    private let monitor = NWPathMonitor()

    public var connectionState = CurrentValueSubject<Bool, Never>(true)

    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                self?.connectionState.send(path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
}

private extension String {
    static let networkQueueLabel = "networkQueue"
}
