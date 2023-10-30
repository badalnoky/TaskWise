import SwiftUI

struct DayView {
    @Bindable var viewModel: DayViewModel
}

// swiftlint: disable: closure_body_length
extension DayView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                IconButton(.filter, action: viewModel.didTapFilter)
                IconButton(.add, action: viewModel.didTapAdd)
            }

            Text(viewModel.date, format: .dateTime.year().month().day(.defaultDigits))
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewModel.date, format: .dateTime.weekday(.wide))
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

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
                                ForEach(viewModel.tasks.from(column: column), id: \.id) { task in
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
        }
        .sheet(isPresented: $viewModel.isFilterSheetPresented) {
            VStack {
                HStack {
                    Button("Cancel", role: .cancel) { viewModel.isFilterSheetPresented.toggle() }
                    Spacer()
                    Button("Filter", action: viewModel.didChangeFilter)
                }
                TextField(String.empty, text: $viewModel.filterText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Text(Str.taskPriorityLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedPriority) {
                        ForEach(viewModel.priorities, id: \.level) {
                            Text($0.name).tag($0)
                        }
                    }
                }

                HStack {
                    Text(Str.taskCategoryLabel)
                    Spacer()
                    Picker(String.empty, selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.categories, id: \.self) {
                            Text($0.name)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    DayView(viewModel: .mock)
}
