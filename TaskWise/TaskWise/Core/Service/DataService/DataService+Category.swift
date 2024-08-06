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

    func deleteCategory(_ category: Category) throws {
        if categories.value.count == .one {
            throw DataOperationError.lastOfKind(type: Category.entityName)
        } else if (category.wTasks?.count ?? .zero) > .zero {
            throw DataOperationError.existingRelationship(type: Category.entityName)
        } else {
            delete(item: category)
        }
        fetchCategories()
    }
}
