import SwiftUI

struct DashboardView {
    @Bindable var viewModel: DashboardViewModel
}
// swiftlint: disable: closure_body_length
extension DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                StyledText(text: Str.Dashboard.title, style: .title)
                    .padding(.horizontal, .padding8)

                StyledDate(date: viewModel.date, style: .date)
                    .padding(.horizontal, .padding8)
            }
            .defaultViewPadding()

            GeometryReader { geometry in
                VStack {
                    TaskProgressIndicator(done: viewModel.doneCount, total: viewModel.totalCount, width: geometry.size.width * .indicatorScaledWidth)
                        .padding(.top, .padding32)

                    TabView(selection: $viewModel.activeTab) {
                        ForEach(viewModel.columns, id: \.self) { column in
                            VStack(spacing: .zero) {
                                ColumnHeader(text: column.name)
                                ScrollView {
                                    Color.clear
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .frame(height: .borderWidth)
                                    ForEach(viewModel.tasks.from(column: column), id: \.id) { task in
                                        TaskItemView(
                                            title: task.title,
                                            priority: task.priority.name,
                                            category: task.category.name,
                                            categoryColor: .from(components: task.category.colorComponents)
                                        )
                                        .gesture(
                                            DoubleAndSingleTapGesture(
                                                task: task,
                                                columns: viewModel.columns,
                                                onDoubleTap: viewModel.didChangeColumn,
                                                onSingleTap: viewModel.didTapTask
                                            )
                                        )
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
                            .tag(column.index)
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
        .onOpenURL { viewModel.openAt($0) }
    }
}

#Preview {
    DashboardView(viewModel: .mock)
}
