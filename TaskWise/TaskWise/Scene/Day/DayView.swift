import SwiftUI

struct DayView {
    @Bindable var viewModel: DayViewModel
}

// swiftlint: disable: closure_body_length
extension DayView: View {
    var body: some View {
        VStack {
            VStack {
                StyledDate(date: viewModel.date, style: .titleDate)

                StyledDate(date: viewModel.date, style: .weekday)
            }
            .defaultViewPadding()

            GeometryReader { geometry in
                TabView {
                    ForEach(viewModel.columns, id: \.self) { column in
                        VStack(spacing: .zero) {
                            ColumnHeader(text: column.name)
                            ScrollView {
                                Color.clear
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: .borderWidth)
                                ForEach(viewModel.filteredTasks.from(column: column), id: \.id) { task in
                                    TaskItemView(
                                        title: task.title,
                                        priority: task.priority.name,
                                        category: task.category.name,
                                        categoryColor: .from(components: task.category.colorComponents)
                                    )
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
        .sheet(isPresented: $viewModel.isFilterSheetPresented) {
            filterView
        }
        .dayNavigationBar(filterAction: viewModel.didTapFilter, addAction: viewModel.didTapAdd)
    }
}

extension DayView {
    var filterView: some View {
        VStack(spacing: .padding12) {
            HStack {
                Button("Clear all", action: viewModel.didTapClearFilters)
                    .buttonStyle(TextButtonStyle())
                Spacer()
                Button("Close") { viewModel.isFilterSheetPresented.toggle() }
                    .buttonStyle(TextButtonStyle())
            }

            StyledField(style: .base, title: "Search", text: $viewModel.filterText)

            TaskRow(title: Str.taskPriorityLabel, selected: $viewModel.selectedPriority) {
                Text("No selection").tag(nil as Priority?)
                ForEach(viewModel.priorities, id: \.level) {
                    Text($0.name).tag($0 as Priority?)
                }
            }

            TaskRow(title: Str.taskCategoryLabel, selected: $viewModel.selectedCategory) {
                Text("No selection").tag(nil as Category?)
                ForEach(viewModel.categories, id: \.self) {
                    Text($0.name).tag($0 as Category?)
                }
            }
            Spacer()
        }
        .presentationDetents([.height(.defaultFilterSheetHeight)])
        .defaultViewPadding()
    }
}

#Preview {
    DayView(viewModel: .mock)
}
