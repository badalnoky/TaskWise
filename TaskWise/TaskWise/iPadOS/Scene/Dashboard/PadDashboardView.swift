import CalendarDatePicker
import SwiftUI

struct PadDashboardView {
    private typealias Txt = Str.Pad.Dashboard

    @Bindable var viewModel: PadDashboardViewModel

    init() {
        self.viewModel = PadDashboardViewModel()
    }
}

extension PadDashboardView: View {
    var body: some View {
        VStack(spacing: .padding32) {
            topTiles

            columns
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .padDashboardNavigationBar(
            filterText: $viewModel.filterText,
            selectedPriority: $viewModel.selectedPriority,
            selectedCategory: $viewModel.selectedCategory,
            didTapTaskAction: viewModel.didTapSearchedTask
        )
    }
}

private extension PadDashboardView {
    var topTiles: some View {
        HStack(alignment: .top, spacing: .padding32) {
            VStack(spacing: .zero) {
                StyledDate(date: viewModel.selectedDate, style: .date)
                StyledDate(date: viewModel.selectedDate, style: .weekday)
                StyledText(text: Txt.todayTitle, style: .title).opacity(viewModel.isToday ? .one : .zero)

                Spacer()

                TaskProgressIndicator(
                    done: viewModel.doneCount,
                    total: viewModel.totalCount,
                    width: .padIndicatorSize
                )
                .frame(minHeight: .defaultListHeight)

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

    var columns: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: .zero) {
                    ForEach(viewModel.columns, id: \.self) { column in
                        VStack(spacing: .padding8) {
                            ColumnHeader(text: column.name)
                            ScrollView {
                                Color.clear
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: .borderWidth)
                                ForEach(viewModel.tasks.from(column: column).sortedByDateAndPriority, id: \.id) { task in
                                    TaskItemView(
                                        title: task.title,
                                        priority: task.priority.name,
                                        category: task.category.name,
                                        categoryColor: .from(components: task.category.colorComponents)
                                    )
                                }
                                .padding(.horizontal, .padding16)
                            }
                        }
                        .frame(width: geometry.size.width.third)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, .padding12)
    }
}

#Preview {
    NavigationStack {
        PadDashboardView()
    }
}
