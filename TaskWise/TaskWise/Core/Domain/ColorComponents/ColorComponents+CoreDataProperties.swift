import CoreData
import Foundation

extension ColorComponents {
    public static let entityName: String = "ColorComponents"

    @NSManaged public var wAlpha: Double
    @NSManaged public var wBlue: Double
    @NSManaged public var wGreen: Double
    @NSManaged public var wRed: Double
    @NSManaged public var wCategory: Category?

    public var alpha: Double { wAlpha }
    public var blue: Double { wBlue }
    public var green: Double { wGreen }
    public var red: Double { wRed }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorComponents> {
        NSFetchRequest<ColorComponents>(entityName: Self.entityName)
    }
}

extension ColorComponents: Identifiable {}
