import Combine
import Foundation

public extension Publisher {
    func sink(
        receiveValue: @escaping ((Self.Output) -> Void),
        receiveError: @escaping ((Self.Failure) -> Void)
    ) -> AnyCancellable {
        sink { completion in
            switch completion {
            case .failure(let error): receiveError(error)
            default: break
            }
        } receiveValue: { value in
            receiveValue(value)
        }
    }

    func sinkOnMainQueue(
        receiveValue: @escaping ((Self.Output) -> Void),
        receiveError: @escaping ((Self.Failure) -> Void)
    ) -> AnyCancellable {
        receive(on: DispatchQueue.main).sink(receiveValue: receiveValue, receiveError: receiveError)
    }
}
