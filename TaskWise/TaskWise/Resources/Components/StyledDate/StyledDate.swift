import SwiftUI

public struct StyledDate {
    var date: Date
    var style: StyledDateModel

    public init(date: Date, style: StyledDateModel) {
        self.date = date
        self.style = style
    }
}

extension StyledDate: View {
    public var body: some View {
        Text(date, format: style.format)
            .textStyle(style.textStyle)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        StyledDate(date: .now, style: .date)
        StyledDate(date: .now, style: .weekday)
    }
}
