import CoreData

extension TaskColumn {
    public struct DTO {
        let id: UUID
        let index: Int
        let name: String

        init(id: UUID, index: Int, name: String) {
            self.id = id
            self.index = index
            self.name = name
        }

        init(from column: TaskColumn) {
            self.id = column.id
            self.index = column.index
            self.name = column.name
        }

        static var placeholder: DTO {
            // swiftlint: disable force_unwrapping
            .init(id: UUID(uuidString: "03648B00-ACD7-47E9-8819-63EA18F290C0")!, index: 1, name: "TODO")
            // swiftlint: enable force_unwrapping
        }
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let column = TaskColumn(context: context)
        column.wId = dto.id
        column.wIndex = Int16(dto.index)
        column.wName = dto.name
    }
}
