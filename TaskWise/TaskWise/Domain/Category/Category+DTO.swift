import CoreData

extension Category {
    public struct DTO {
        let id: UUID
        let name: String
        let colorComponents: ColorComponents.DTO
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let category = Category(context: context)
        category.wId = dto.id
        category.wName = dto.name
        category.wColorComponents = ColorComponents.create(from: dto.colorComponents, on: context)
    }
}
