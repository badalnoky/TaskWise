import SwiftUI

struct ColorGrid: View {
    var selectedColor: Binding<Color>

    // swiftlint: disable: closure_body_length
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: .zero), count: .colorGridColumnCount)) {
                ForEach(.zero..<Int.colorGridColumnCount, id: \.self) { column in
                    VStack(spacing: .zero) {
                        ForEach(.zero..<Int.colorGridRowCount, id: \.self) { row in
                            let color = Color.basePickerColorGrid[column][row]
                            let isSelected = CIColor(color: UIColor(color)) == CIColor(color: UIColor(selectedColor.wrappedValue))
                            let isTopLeading = column == .zero && row == .zero
                            let isTopTrailing = column == .colorGridMaxX && row == .zero
                            let isBottomLeading = column == .zero && row == .colorGridMaxY
                            let isBottomTrailing = column == .colorGridMaxX && row == .colorGridMaxY
                            UnevenRoundedRectangle(
                                cornerRadii: RectangleCornerRadii(
                                    topLeading: isTopLeading ? .calendarCornerRadius : .zero,
                                    bottomLeading: isBottomLeading ? .calendarCornerRadius : .zero,
                                    bottomTrailing: isBottomTrailing ? .calendarCornerRadius : .zero,
                                    topTrailing: isTopTrailing ? .calendarCornerRadius : .zero
                                )
                            )
                            .aspectRatio(.one, contentMode: .fit)
                            .foregroundStyle(color)
                            .overlay {
                                UnevenRoundedRectangle(
                                    cornerRadii: RectangleCornerRadii(
                                        topLeading: isTopLeading ? .calendarCornerRadius : .baseLineWidth,
                                        bottomLeading: isBottomLeading ? .calendarCornerRadius : .baseLineWidth,
                                        bottomTrailing: isBottomTrailing ? .calendarCornerRadius : .baseLineWidth,
                                        topTrailing: isTopTrailing ? .calendarCornerRadius : .baseLineWidth
                                    )
                                )
                                .strokeBorder(.white, lineWidth: isSelected ? .baseLineWidth : .zero)
                                .shadow(color: .gray, radius: .baseLineWidth)
                            }
                            .onTapGesture {
                                selectedColor.wrappedValue = color
                            }
                        }
                    }
                }
            }
        }
    }
    // swiftlint: enable: closure_body_length
}

#Preview {
    @State var color = Color.blue
    return ColorGrid(selectedColor: $color)
}
