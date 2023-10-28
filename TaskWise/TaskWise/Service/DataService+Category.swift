extension DataService {
    func addCategory(_ category: Category.DTO) {
        Category.create(from: category, on: context)
        save()
        fetchCategories()
    }

    func updateCategoryName(on category: Category, to newName: String) {
        category.wName = newName
        save()
        fetchCategories()
    }

    func updateColor(on category: Category, with newColor: ColorComponents.DTO) {
        category.wColorComponents?.update(with: newColor)
        save()
        fetchCategories()
    }

    func deleteCategory(_ category: Category) {
        // TODO: delete, handle when it has tasks, or it is the last
        fetchCategories()
    }
}
