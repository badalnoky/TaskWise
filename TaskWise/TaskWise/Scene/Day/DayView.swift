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
                                    .alert(Str.Alert.message + Str.Alert.repeatingTask, isPresented: $viewModel.isAlertPresented) {
                                        Button(Str.Alert.deleteOnlyThis, role: .destructive) {
                                            viewModel.didTapDeleteOnlyThis(task: task)
                                        }
                                        Button(Str.Alert.deleteAll, role: .destructive) { viewModel.didTapDeleteRepeating(task: task) }
                                        Button(Str.Alert.cancel, role: .cancel) {}
                                    }
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
                Button(Str.Filter.clearAllLabel, action: viewModel.didTapClearFilters)
                    .buttonStyle(TextButtonStyle())
                Spacer()
                Button(Str.Filter.closeLabel) { viewModel.isFilterSheetPresented.toggle() }
                    .buttonStyle(TextButtonStyle())
            }

            StyledField(style: .base, title: Str.Calendar.searchLabel, text: $viewModel.filterText)

            TaskRow(title: Str.Task.priorityLabel, selected: $viewModel.selectedPriority) {
                Text(Str.Filter.noSelectionLabel).tag(nil as Priority?)
                ForEach(viewModel.priorities, id: \.level) {
                    Text($0.name).tag($0 as Priority?)
                }
            }

            TaskRow(title: Str.Task.categoryLabel, selected: $viewModel.selectedCategory) {
                Text(Str.Filter.noSelectionLabel).tag(nil as Category?)
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
