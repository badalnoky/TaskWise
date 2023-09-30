//import CloudKit
//import Combine
//
//// TODO: Build this to an actual service
//@Observable final class CloudDataService {
//    var isSignedIn = false
//    var tasks: [Task] = []
//    private var cancellables = Set<AnyCancellable>()
//
//    private func getICloudStatus() {
//        CloudKitHandler.getCloudStatus()
//            .sinkOnMainQueue { [weak self] in
//                self?.isSignedIn = $0
//                print("isSignedIn is true")
//            } receiveError: { error in
//                print("recieved some error")
//            }.store(in: &cancellables)
//    }
//
//    private func fetch() {
//        CloudKitHandler.fetch(predicate: .init(value: true), recordType: "Tasks")
//            .sinkOnMainQueue { [weak self] (items: [Task]) in
//                self?.tasks = items
//            } receiveError: { error in
//                print("recieved some error")
//            }.store(in: &cancellables)
//    }
//
//    private func addItem(title: String) {
//        CloudKitHandler.add(item: Task(title: title))
//            .sinkOnMainQueue {
//                print($0)
//            } receiveError: { error in
//                print("recieved some error")
//            }.store(in: &cancellables)
//    }
//
//    private func updateItem() {
//        tasks[0].update(title: "Task1Updated")
//        CloudKitHandler.update(item: tasks[0])
//            .sinkOnMainQueue {
//                print($0)
//            } receiveError: { error in
//                print("recieved some error")
//            }.store(in: &cancellables)
//    }
//
//    private func deleteItem() {
//        CloudKitHandler.delete(item: tasks[0])
//            .sinkOnMainQueue {
//                print($0)
//            } receiveError: { error in
//                print("recieved some error")
//            }.store(in: &cancellables)
//    }
//}
