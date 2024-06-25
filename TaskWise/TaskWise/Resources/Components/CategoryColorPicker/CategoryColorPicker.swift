import IntegratedColorPicker
import SwiftUI

struct CategoryColorPicker: View {
    @State private var category: Category
    @State private var selectedColor: Color
    private var isEditable: Bool
    private var colorChangedAction: (ColorComponents.DTO) -> Void

    var body: some View {
        IntegratedColorPicker(selectedColor: $selectedColor, isEditable: isEditable) {
            TaskItemView(
                title: Str.Settings.exampleTitle,
                priority: Str.Settings.examplePriority,
                category: category.name,
                categoryColor: selectedColor
            )
        }
        .onChange(of: selectedColor) {
            withAnimation {
                colorChangedAction(selectedColor.components)
            }
        }
    }

    init(
        category: Category,
        isEditable: Bool,
        colorChangedAction: @escaping (ColorComponents.DTO) -> Void
    ) {
        self.category = category
        self.selectedColor = Color.from(components: category.colorComponents)
        self.isEditable = isEditable
        self.colorChangedAction = colorChangedAction
    }
}

#Preview {
    VStack {
        CategoryColorPicker(category: .mock, isEditable: true) { _ in }
        CategoryColorPicker(category: .mock, isEditable: false) { _ in }
    }
}
