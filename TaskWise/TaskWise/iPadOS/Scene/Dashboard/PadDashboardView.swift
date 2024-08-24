import CalendarDatePicker
import SwiftUI

struct PadDashboardView {
    @Bindable var viewModel: PadDashboardViewModel

    init() {
        self.viewModel = PadDashboardViewModel()
    }
}

extension PadDashboardView: View {
    var body: some View {
        VStack(spacing: .padding32) {
            topTiles

            GeometryReader { geometry in
                ScrollView(.horizontal) {
                    HStack(spacing: .zero) {
                        ForEach(viewModel.columns, id: \.self) { column in
                            VStack(spacing: .padding8) {
                                ColumnHeader(text: column)
                                ScrollView {
                                    ForEach(0...100, id: \.self) { task in
                                        Text("\(task)")
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, .padding8)
                                            .neumorphic()
                                    }
                                    .padding(.horizontal, .padding16)
                                }
                            }
                            .frame(width: geometry.size.width / 3)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, .padding12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .padDashboardNavigationBar(
            searchAction: {},
            filterAction: {},
            addAction: {}
        )
    }
}

private extension PadDashboardView {
    var topTiles: some View {
        HStack(alignment: .top, spacing: .padding32) {
            VStack(spacing: .zero) {
                StyledText(text: "Today", style: .title)

                StyledDate(date: .now, style: .date)

                Spacer()

                TaskProgressIndicator(
                    done: 3,
                    total: 6,
                    width: 200
                )

                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.vertical, .padding32)
            .padding(.horizontal, .padding8)

            CalendarDatePicker(selectedDate: $viewModel.selectedDate) {}
                .frame(maxHeight: .infinity)
                .neumorphic()
        }
        .padding(.padding32)
    }
}

#Preview {
    NavigationStack {
        PadDashboardView()
    }
}
