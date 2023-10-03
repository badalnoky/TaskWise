import SwiftData

struct Category: Codable, Hashable {
    let name: String

    init(name: String) {
        self.name = name
    }
}

extension Category {
    static var defaultCategories: [Category] {
        [
            Category(name: "Work"),
            Category(name: "School"),
            Category(name: "Health"),
            Category(name: "Freetime"),
            Category(name: "Other")
        ]
    }
}

extension Category {
    static var mock: Category {
        Category(name: .empty)
    }
}

@Model final class CustomCategory {
    var category = Category.defaultCategories[0]

    init(category: Category) {
        self.category = category
    }
}
