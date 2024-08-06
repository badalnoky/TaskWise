import CoreData

extension Priority {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let low = Priority(context: context)
        low.wId = UUID(uuidString: "AC387949-34E7-46FB-9E45-98412FD4B4AF")
        low.wLevel = 1
        low.wName = "Low"

        let medium = Priority(context: context)
        medium.wId = UUID(uuidString: "4B5148CA-60A0-441B-BFD3-9B6A2DB04302")
        medium.wLevel = 2
        medium.wName = "Medium"

        let high = Priority(context: context)
        high.wId = UUID(uuidString: "8925F42B-4C7D-4359-8FF5-0C92D4DD26E0")
        high.wLevel = 3
        high.wName = "High"
    }
}
