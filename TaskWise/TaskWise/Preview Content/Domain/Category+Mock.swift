import Foundation

#if DEBUG
extension Category {
    static var mock: Category {
        let category = Category(context: PreviewDataController.global.context)
        category.wId = UUID()
        category.wName = "Category"
        category.wColorComponents = .mock
        return category
    }
}
#endif
