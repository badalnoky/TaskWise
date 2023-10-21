import CoreData
import SwiftUI

#if DEBUG
class PreviewDataController {
    static let global = PreviewDataController()
    private let container = NSPersistentContainer(name: Str.dataServiceContainerName)
    var context: NSManagedObjectContext { container.viewContext }

    private init() {
        // swiftlint: disable: force_unwrapping
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { description, error in
            if error != nil { print(Str.dataServiceContainerFailureMessage) }
        }
    }
}
#endif
