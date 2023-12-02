import SwiftUI

struct CalendarView {
    @Bindable var viewModel: CalendarViewModel
    @FocusState var focused: Bool
}

// swiftlint: disable: closure_body_length
extension CalendarView: View {
    var body: some View {
        VStack {
            if viewModel.isSearching {
                VStack {
                    HStack {
                        StyledField(style: .base, title: "Search", text: $viewModel.searchText)
                            .focused($focused, equals: true)
                        Button("Cancel") {
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
                .transition(.move(edge: .top).combined(with: .opacity))
            } else {
                VStack {
                    Spacer()

                    DatePicker(String.empty, selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .onChange(of: viewModel.selectedDate) {
                            viewModel.didTapDate()
                        }

                    if viewModel.isListed {
                        GeometryReader { geometry in
                            TabView {
                                ForEach(viewModel.columns, id: \.self) { column in
                                    VStack {
                                        HStack {
                                            Text(column.name)
                                                .font(.title)
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        ScrollView {
                                            ForEach(viewModel.filteredTasks.from(column: column), id: \.id) { task in
                                                HStack {
                                                    Text(task.title)
                                                        .padding()
                                                        .onTapGesture {
                                                            viewModel.didTapTask(task)
                                                        }
                                                    Spacer()
                                                    Menu {
                                                        Button("Delete") {
                                                            viewModel.didTapDelete(task: task)
                                                        }
                                                    } label: {
                                                        IconButton(.more) {}
                                                    }
                                                }
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
        .defaultViewPadding()
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
    CalendarView(viewModel: .mock)
}
