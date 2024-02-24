import CoreData
import Foundation

extension UserSettings {
    @NSManaged public var categoriesInitiated: Bool
    @NSManaged public var columnsInitiated: Bool
    @NSManaged public var prioritiesInitiated: Bool

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }
}

extension UserSettings: Identifiable {}
