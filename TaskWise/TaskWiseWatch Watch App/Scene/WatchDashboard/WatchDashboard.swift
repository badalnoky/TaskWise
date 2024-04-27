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
                    CompletionView(done: viewModel.doneTaskCount, total: viewModel.allTaskCount)
                        .transition(.scale(scale: .watchCompletionScale, anchor: .topLeading))
                    Text(Date.now, format: .dateTime.month(.wide).day(.defaultDigits))
                        .transition(.scale(scale: .watchCompletionScale, anchor: .topLeading))
                }
            }
            .tag(Int.zero)
            .containerBackground(.background.gradient, for: .tabView)
            .padding()

            NavigationStack {
                ScrollView {
                    ForEach(viewModel.tasks, id: \.self) { task in
                        NavigationLink(value: task) {
                            TaskCell(task: task)
                        }
                    }
                }
                .navigationDestination(for: String.self) { task in
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
                CompletionView(done: viewModel.doneTaskCount, total: viewModel.allTaskCount)
                    .opacity(isToolbarPresented ? .one : .zero)
            }
        }
        .navigationTitle(viewModel.firstColumnName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        WatchDashboard()
    }
}
