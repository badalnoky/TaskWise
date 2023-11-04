import CoreData
import SwiftUI

extension Category {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let work = Category(context: context)
        work.wId = UUID()
        work.wName = "Work"
        work.wColorComponents = ColorComponents.create(from: Color.blue.components, on: context)

        let school = Category(context: context)
        school.wId = UUID()
        school.wName = "School"
        school.wColorComponents = ColorComponents.create(from: Color.yellow.components, on: context)

        let health = Category(context: context)
        health.wId = UUID()
        health.wName = "Health"
        health.wColorComponents = ColorComponents.create(from: Color.green.components, on: context)

        let freetime = Category(context: context)
        freetime.wId = UUID()
        freetime.wName = "Freetime"
        freetime.wColorComponents = ColorComponents.create(from: Color.orange.components, on: context)

        let other = Category(context: context)
        other.wId = UUID()
        other.wName = "Other"
        other.wColorComponents = ColorComponents.create(from: Color.purple.components, on: context)
    }
}
