import SwiftUI

struct EditableText: View {
    @State private var item: NamedItem
    @State private var text: String
    private var isEditable: Bool
    private var nameChangedAction: (String) -> Void

    var body: some View {
        TextField(
            String.empty,
            text: $text,
            onEditingChanged: { if !$0 { handleChange() } },
            onCommit: handleChange
        )
        .textFieldStyle(BaseTextFieldStyle())
        .disabled(!isEditable)
    }

    init(item: NamedItem, isEditable: Bool, nameChangedAction: @escaping (String) -> Void) {
        self._item = State(wrappedValue: item)
        self._text = State(wrappedValue: item.name)
        self.isEditable = isEditable
        self.nameChangedAction = nameChangedAction
    }

    private func handleChange() {
        if text != item.name {
            nameChangedAction(text)
        }
    }
}
