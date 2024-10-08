import CalendarDatePicker
import SwiftUI

struct MacDashboardView {
    private typealias Txt = Str.Pad.Dashboard

    @Bindable var viewModel: MacDashboardViewModel

    init() {
        self.viewModel = MacDashboardViewModel()
    }
}

extension MacDashboardView: View {
    var body: some View {
        VStack(spacing: .padding4) {
            topBar

            topTiles

            columns
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .frame(minWidth: .macMinSize, minHeight: .macMinSize)
        .sheet(isPresented: $viewModel.isTaskPresented) {
            if let task = viewModel.presentedTask {
                MacTaskPopoverView(
                    viewModel: .init(
                        dataService: viewModel.dataService,
                        task: task,
                        priorities: viewModel.priorities,
                        categories: viewModel.categories,
                        columns: viewModel.columns
                    )
                )
            }
        }
    }
}

extension MacDashboardView {
    var topBar: some View {
        HStack {
            MacIconButton(image: .settings, action: viewModel.didTapSettings)
                .popover(isPresented: $viewModel.isSettingsOpen) {
                    MacSettingsView()
                }

            Spacer()

            MacIconButton(image: .filter, action: viewModel.didTapFilter)
                .popover(isPresented: $viewModel.isFilterOpen) {
                    FilterPopoverView(
                        filterText: $viewModel.filterText,
                        selectedPriority: $viewModel.selectedPriority,
                        selectedCategory: $viewModel.selectedCategory
                    )
                }

            MacIconButton(image: .search, action: viewModel.didTapSearch)
                .popover(isPresented: $viewModel.isSearchOpen) {
                    SearchPopoverView(didTapTaskAction: viewModel.didTapSearchedTask)
                }

            MacIconButton(image: .add, action: viewModel.didTapAdd)
                .popover(isPresented: $viewModel.isAddTaskOpen) {
                    MacAddTaskPopoverView()
                }
        }
        .padding(.vertical, .padding16)
        .padding(.horizontal, .padding12)
    }

    var topTiles: some View {
        HStack(alignment: .top, spacing: .padding32) {
            VStack(spacing: .zero) {
                StyledDate(date: viewModel.selectedDate, style: .date)
                StyledDate(date: viewModel.selectedDate, style: .weekday)
                StyledText(text: Txt.todayTitle, style: .title).opacity(viewModel.isToday ? .one : .zero)
                    .padding(.bottom, .padding50)

                TaskProgressIndicator(
                    done: viewModel.doneCount,
                    total: viewModel.totalCount,
                    width: .padIndicatorSize
                )
                .frame(height: .defaultListHeight)
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, .padding8)

            MacCalendarDatePicker(selectedDate: $viewModel.selectedDate) {}
                .neumorphic()
        }
        .padding(.top, .padding16)
        .padding(.horizontal, .padding16)
        .padding(.bottom, .padding8)
    }

    // swiftlint: disable closure_body_length
    var columns: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: .zero) {
                    ForEach(viewModel.columns, id: \.self) { column in
                        VStack(spacing: .padding8) {
                            ColumnHeader(text: column.name, style: .macOS)
                            ScrollView {
                                Color.clear.frame(maxWidth: .infinity, alignment: .center).frame(height: .borderWidth)
                                ForEach(
                                    viewModel.filteredTasks.from(column: column).sortedByDateAndPriority,
                                    id: \.id
                                ) { task in
                                    TaskItemView(
                                        title: task.title,
                                        priority: task.priority.name,
                                        category: task.category.name,
                                        categoryColor: .from(components: task.category.colorComponents)
                                    )
                                    .onDrag {
                                        viewModel.draggedTask = task
                                        return NSItemProvider(object: task.id.uuidString as NSString)
                                    }
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
                                    .alert(Str.Alert.message + Str.Alert.repeatingTask, isPresented: $viewModel.isAlertPresented) {
                                        Button(Str.Alert.deleteOnlyThis, role: .destructive) { viewModel.didTapDeleteOnlyThis(task: task) }
                                        Button(Str.Alert.deleteAll, role: .destructive) { viewModel.didTapDeleteRepeating(task: task) }
                                        Button(Str.Alert.cancel, role: .cancel) {}
                                    }
                                }
                                .padding(.horizontal, .padding16)
                            }
                            .onDrop(
                                of: [.text],
                                delegate: DashboardDropViewDelegate(
                                    destinationColumn: column,
                                    draggedItem: $viewModel.draggedTask,
                                    moveAction: viewModel.didChangeColumn
                                )
                            )
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
    MacDashboardView()
}
