import SwiftUI

struct MacCategoryColorPicker: View {
    @State private var category: Category
    @State private var selectedColor: Color
    private var isEditable: Bool
    private var colorChangedAction: (ColorComponents.DTO) -> Void

    var body: some View {
        ColorPicker(String.empty, selection: $selectedColor)
            .disabled(!isEditable)
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
        MacCategoryColorPicker(category: .mock, isEditable: true) { _ in }
        MacCategoryColorPicker(category: .mock, isEditable: false) { _ in }
    }
}
