import CoreData

extension Priority {
    public struct DTO {
        let id: UUID
        let level: Int
        let name: String
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let priority = Priority(context: context)
        priority.wId = dto.id
        priority.wLevel = Int16(dto.level)
        priority.wName = dto.name
    }
}
