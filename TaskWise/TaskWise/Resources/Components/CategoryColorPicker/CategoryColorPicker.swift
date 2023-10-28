import SwiftUI

struct CategoryColorPicker: View {
    @State private var category: Category
    @State private var selectedColor: Color
    private var isEditable: Bool
    private var colorChangedAction: (ColorComponents.DTO) -> Void

    var body: some View {
        ColorPicker(String.empty, selection: $selectedColor, supportsOpacity: true)
            .labelsHidden()
            .disabled(!isEditable)
            .onChange(of: selectedColor) {
                colorChangedAction(selectedColor.components)
            }
            .overlay {
                Circle()
                    .sized(.defaultColorPickerSize)
                    .foregroundStyle(selectedColor)
                    .opacity(isEditable ? .zero : 1)
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
    CategoryColorPicker(category: .mock, isEditable: false) { _ in }
}
