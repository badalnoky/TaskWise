import CoreData

extension TaskColumn {
    public struct DTO {
        let id: UUID
        let index: Int
        let name: String
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let column = TaskColumn(context: context)
        column.wId = dto.id
        column.wIndex = Int16(dto.index)
        column.wName = dto.name
    }
}
