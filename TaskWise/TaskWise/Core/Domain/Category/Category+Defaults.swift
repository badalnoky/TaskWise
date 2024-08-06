import CoreData
import SwiftUI

extension Category {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let work = Category(context: context)
        work.wId = UUID(uuidString: "7F07A84A-B49B-440D-9D85-BA319F183D18")
        work.wName = "Work"
        work.wColorComponents = ColorComponents.create(from: Color.blue.components, on: context)

        let school = Category(context: context)
        school.wId = UUID(uuidString: "52C1FDE4-C3BC-42F1-BB84-46FA3AB7B892")
        school.wName = "School"
        school.wColorComponents = ColorComponents.create(from: Color.yellow.components, on: context)

        let health = Category(context: context)
        health.wId = UUID(uuidString: "06F48B40-D7A0-465F-9E94-933442D6717E")
        health.wName = "Health"
        health.wColorComponents = ColorComponents.create(from: Color.green.components, on: context)

        let freetime = Category(context: context)
        freetime.wId = UUID(uuidString: "4A12A116-9A4E-4293-A04F-09927E984E73")
        freetime.wName = "Freetime"
        freetime.wColorComponents = ColorComponents.create(from: Color.orange.components, on: context)

        let other = Category(context: context)
        other.wId = UUID(uuidString: "D13E5313-7189-4DBC-9CF0-CAB507285987")
        other.wName = "Other"
        other.wColorComponents = ColorComponents.create(from: Color.purple.components, on: context)
    }
}
