import SwiftUI

public struct StyledText {
    var text: String
    var style: StyledTextModel

    public init(text: String, style: StyledTextModel) {
        self.text = text
        self.style = style
    }
}

extension StyledText: View {
    public var body: some View {
        Text(text)
            .textStyle(style.textStyle)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        StyledText(text: "Text", style: .title)
        StyledText(text: "Text", style: .base)
    }
}
