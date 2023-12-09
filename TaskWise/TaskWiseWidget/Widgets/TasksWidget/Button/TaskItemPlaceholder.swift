import SwiftUI

struct TaskItemPlaceholder: View {
    var body: some View {
        HStack {
            VStack {
                Text(String.capitalPlacholder)
                    .foregroundStyle(.widgetBackground)
                    .textStyle(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String.capitalPlacholder)
                    .foregroundStyle(.widgetBackground)
                    .textStyle(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, .padding8)

            Text(String.capitalPlacholder)
                .foregroundStyle(.widgetBackground)
                .font(TextStyle.footnote.font)
                .padding(.padding4)
        }
        .padding(.horizontal, .padding8)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.borderWidth)
        .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
    }
}

#Preview {
    TaskItemPlaceholder()
}
