import SwiftUI

public struct StyledField {
    private let style: StyledFieldModel
    private let title: String
    private let text: Binding<String>

    public init(style: StyledFieldModel, title: String, text: Binding<String>) {
        self.style = style
        self.title = title
        self.text = text
    }
}

extension StyledField: View {
    public var body: some View {
        if style == .description {
            TextField(title, text: text, axis: .vertical)
                .lineLimit(3...)
                .textFieldOverlay()
                .textStyle(style.textStyle)
        } else {
            TextField(title, text: text)
                .textFieldOverlay()
                .textStyle(style.textStyle)
        }
    }
}

#Preview {
    @State var text: String = .empty
    return VStack {
        StyledField(style: .base, title: "Step", text: $text)
        StyledField(style: .largeTitle, title: "Title", text: $text)
        StyledField(style: .title, title: "Title", text: $text)
        StyledField(style: .description, title: "Description", text: $text)
    }
}
