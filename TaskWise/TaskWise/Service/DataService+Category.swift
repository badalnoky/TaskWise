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
        // TODO: Resolve this
        if categories.value.count == .one {
            print("return an error saying there needs to be at least one category")
        } else if (category.wTasks?.count ?? .zero) > .zero {
            print("return an error saying that some task use it")
        } else {
            delete(item: category)
        }
        fetchCategories()
    }
}
