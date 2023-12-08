import SwiftUI

struct TaskWidgetHeader: View {
    var name: String

    var body: some View {
        Text(name)
            .foregroundStyle(.accent)
            .textStyle(.callout)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: .padding12)
                    .fill(Color.widgetHeader)
                    .frame(height: 30)
            }
            .padding(.horizontal, .padding4)
    }
}

#Preview {
    TaskWidgetHeader(name: "TODO")
}
