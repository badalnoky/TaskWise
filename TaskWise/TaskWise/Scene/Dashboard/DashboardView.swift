import SwiftUI

struct DashboardView {
    let viewModel: DashboardViewModel
}
// swiftlint: disable: closure_body_length
extension DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                StyledText(text: Str.dashboardTitle, style: .title)
                    .padding(.horizontal, .padding8)

                StyledDate(date: viewModel.date, style: .date)
                    .padding(.horizontal, .padding8)
            }
            .defaultViewPadding()

            GeometryReader { geometry in
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: .indicatorBorderWidth)
                            .frame(width: geometry.size.width * 0.4)
                            .padding(.padding32)
                        Text(viewModel.completionText)
                            .font(.title).bold()
                    }

                    TabView {
                        ForEach(viewModel.columns, id: \.self) { column in
                            VStack(spacing: .zero) {
                                ColumnHeader(text: column.name)
                                ScrollView {
                                    Color.clear
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .frame(height: .borderWidth)
                                    ForEach(viewModel.tasks.from(column: column), id: \.id) { task in
                                        TaskItemView(task: task)
                                            .onTapGesture {
                                                viewModel.didTapTask(task)
                                            }
                                            .contextMenu(
                                                ContextMenu {
                                                    TaskContextMenuItems(
                                                        task: task,
                                                        columns: viewModel.columns,
                                                        changeColumnAction: viewModel.didChangeColumn,
                                                        deleteAction: viewModel.didTapDelete
                                                    )
                                                }
                                            )
                                            .padding(.horizontal, .padding16)
                                            .frame(width: geometry.size.width)
                                    }
                                }
                            }
                            .frame(width: geometry.size.width)
                            .padding(.bottom, .padding50)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
        }
        .dashboardNavigationBar(
            settingsAction: viewModel.didTapSettings,
            calendarAction: viewModel.didTapCalendar,
            addAction: viewModel.didTapAddTask
        )
    }
}

#Preview {
    DashboardView(viewModel: .mock)
}
