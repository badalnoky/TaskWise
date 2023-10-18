import CoreData

extension ColorComponents {
    public struct DTO {
        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double
    }
    static func create(from dto: DTO, on context: NSManagedObjectContext) -> ColorComponents {
        let components = ColorComponents(context: context)
        components.wRed = dto.red
        components.wGreen = dto.green
        components.wBlue = dto.blue
        components.wAlpha = dto.alpha
        return components
    }

    func update(with updated: ColorComponents.DTO) {
        self.wRed = updated.red
        self.wGreen = updated.green
        self.wBlue = updated.blue
        self.wAlpha = updated.alpha
    }
}
