import CalendarDatePicker
import SwiftUI

struct CalendarView {
    @Bindable var viewModel: CalendarViewModel
    @FocusState var focused: Bool
}

// swiftlint: disable closure_body_length
extension CalendarView: View {
    var body: some View {
        VStack {
            if viewModel.isSearching {
                searchView
            } else {
                VStack {
                    CalendarDatePicker(selectedDate: $viewModel.selectedDate) {
                        viewModel.didTapDate()
                    }
                    .padding(.horizontal, .padding16)

                    if viewModel.isListed {
                        GeometryReader { geometry in
                            TabView {
                                ForEach(viewModel.columns, id: \.self) { column in
                                    VStack(spacing: .zero) {
                                        ColumnHeader(text: column.name)
                                        ScrollView {
                                            Color.clear
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .frame(height: .borderWidth)
                                            ForEach(viewModel.filteredTasks.from(column: column).sortedByDateAndPriority, id: \.id) { task in
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
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    } else {
                        Spacer()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isFilterSheetPresented) {
            filterView
        }
        .calendarNavigationBar(
            isListed: viewModel.isListed,
            listAction: viewModel.didTapList,
            searchAction: {
                viewModel.didToggleSearch()
                focused = true
            },
            filterAction: viewModel.didTapFilter
        )
    }
}

extension CalendarView {
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
        .background(Color.appBackground)
    }

    var searchView: some View {
        VStack {
            HStack {
                StyledField(style: .base, title: Str.Calendar.searchLabel, text: $viewModel.searchText)
                    .focused($focused, equals: true)
                Button(Str.Calendar.cancelLabel) {
                    viewModel.didToggleSearch()
                    focused = false
                }
                .buttonStyle(TextButtonStyle())
            }
            ScrollView {
                ForEach(viewModel.foundDates, id: \.self) { date in
                    VStack {
                        StyledDate(date: date, style: .listDate)
                        Divider()
                        ForEach(viewModel.foundTasks.from(date: date), id: \.id) { task in
                            Button(task.title) {
                                viewModel.didTapTask(task)
                            }
                            .buttonStyle(ListButtonStyle(color: .from(components: task.category.colorComponents)))
                        }
                    }
                    .padding(.vertical, .padding8)
                }
            }
            Spacer()
        }
        .defaultViewPadding()
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
