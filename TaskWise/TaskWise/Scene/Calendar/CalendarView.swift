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
                        TextField(String.empty, text: $viewModel.searchText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .focused($focused, equals: true)
                        Button("Cancel") {
                            viewModel.didToggleSearch()
                            focused = false
                        }
                    }
                    ScrollView {
                        ForEach(viewModel.foundTasks, id: \.id) { task in
                            HStack {
                                Text(task.title)
                                    .padding()
                                    .onTapGesture {
                                        viewModel.didTapTask(task)
                                    }
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        IconButton(.list, action: viewModel.didTapList)
                        if viewModel.isListed {
                            IconButton(.filter, action: viewModel.didTapFilter)
                        }
                        IconButton(.search) {
                            viewModel.didToggleSearch()
                            focused = true
                        }
                    }
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
            VStack {
                HStack {
                    Spacer()
                    Button("Close", role: .cancel) { viewModel.isFilterSheetPresented.toggle() }
                }
                TextField(String.empty, text: $viewModel.filterText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Text(Str.taskPriorityLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedPriority) {
                        Text("No selection").tag(nil as Priority?)
                        ForEach(viewModel.priorities, id: \.level) {
                            Text($0.name).tag($0 as Priority?)
                        }
                    }
                }

                HStack {
                    Text(Str.taskCategoryLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedCategory) {
                        Text("No selection").tag(nil as Category?)
                        ForEach(viewModel.categories, id: \.self) {
                            Text($0.name).tag($0 as Category?)
                        }
                    }
                }
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
        }
    }
}

#Preview {
    CalendarView(viewModel: .mock)
}
