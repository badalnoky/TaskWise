import SwiftUI

enum WatchRowStyle {
    case text
    case date
}

struct WatchRow: View {
    let label: String
    var value: String = .empty
    var date: Date = .now
    let style: WatchRowStyle

    var body: some View {
        HStack {
            Text(label + .colon)
                .frame(maxWidth: .infinity, alignment: .leading)
            if style == .text {
                Text(value)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                Text(date, format: .dateTime.hour().minute())
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    init(label: String, value: String) {
        self.label = label
        self.value = value
        self.style = .text
    }

    init(label: String, date: Date) {
        self.label = label
        self.date = date
        self.style = .date
    }
}

#Preview {
    WatchRow(label: "Label", value: "Value")
}
