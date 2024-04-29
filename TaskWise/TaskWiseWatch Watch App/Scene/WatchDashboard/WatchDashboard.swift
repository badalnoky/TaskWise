import SwiftUI

struct WatchDashboard {
    @Bindable var viewModel: WatchDashboardViewModel = .init()
    @Namespace private var dashboardNamespace
    @State private var isToolbarPresented = false
}

extension WatchDashboard: View {
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            VStack {
                if viewModel.selectedTab == .zero {
                    CompletionView(done: viewModel.doneCount, total: viewModel.totalCount)
                        .transition(.scale(scale: .watchCompletionScale, anchor: .topLeading))
                    Text(Date.now, format: .dateTime.month(.wide).day(.defaultDigits))
                        .transition(.scale(scale: .watchCompletionScale, anchor: .topLeading))
                }
            }
            .tag(Int.zero)
            .containerBackground(.background.gradient, for: .tabView)

            NavigationStack {
                ScrollView {
                    ForEach(viewModel.tasksForSelected, id: \.self) { task in
                        NavigationLink(value: task) {
                            TaskCell(
                                title: task.title,
                                priority: task.priority.name,
                                category: task.category.name,
                                categoryColor: .from(components: task.category.colorComponents)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationDestination(for: Task.self) { task in
                    TaskDetailView(task: task)
                }
            }
            .tag(Int.one)
            .containerBackground(.background.gradient, for: .tabView)
        }
        .onChange(of: viewModel.selectedTab) {
            withAnimation {
                isToolbarPresented = viewModel.selectedTab != .zero
            }
        }
        .tabViewStyle(.verticalPage)
        .toolbar(isToolbarPresented ? .visible : .hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CompletionView(done: viewModel.doneCount, total: viewModel.totalCount)
                    .opacity(isToolbarPresented ? .one : .zero)
            }

            if viewModel.selectedColumn != .zero {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: viewModel.didTapPreviousColumn) {
                        Image.back
                    }
                    .opacity(isToolbarPresented ? .one : .zero)
                }
            } else {
                ToolbarItem(placement: .bottomBar) {
                    Color.clear
                }
            }

            if viewModel.columns.count > .one, viewModel.selectedColumn != viewModel.columns.count.previous {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: viewModel.didTapNextColumn) {
                        Image.next
                    }
                    .opacity(isToolbarPresented ? .one : .zero)
                }
            } else {
                ToolbarItem(placement: .bottomBar) {
                    Color.clear
                }
            }
        }
        .navigationTitle(viewModel.selectedColumnName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        WatchDashboard()
    }
}
