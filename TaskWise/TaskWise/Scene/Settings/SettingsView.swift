import SwiftUI

struct SettingsView {
    @Bindable var viewModel: SettingsViewModel
}
// swiftlint: disable: closure_body_length
extension SettingsView: View {
    var body: some View {
        VStack(spacing: .padding16) {
            Text(Str.settingsTitle)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            TabView {
                VStack {
                    HStack {
                        Spacer()
                        IconButton(.edit) {
                            EditMode.toggle(mode: &viewModel.categoryEditMode)
                        }
                    }

                    List {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category.name)
                        }
                        .onDelete { _ in }
                        .onMove { _, _ in }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                    }
                    .listStyle(.plain)
                }
                .tabItem {
                    Text(Str.settingsCategoriesLabel)
                }
                .environment(\.editMode, $viewModel.categoryEditMode)

                VStack {
                    HStack {
                        Spacer()
                        IconButton(.edit) {
                            EditMode.toggle(mode: &viewModel.columnEditMode)
                        }
                    }

                    List {
                        ForEach(viewModel.columns, id: \.self) { column in
                            Text(column.name)
                        }
                        .onDelete { _ in }
                        .onMove { _, _ in }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                    }
                    .listStyle(.plain)
                }
                .tabItem {
                    Text(Str.settingsColumnsLabel)
                }
                .environment(\.editMode, $viewModel.columnEditMode)

                VStack {
                    HStack {
                        Spacer()
                        IconButton(.edit) {
                            EditMode.toggle(mode: &viewModel.priorityEditMode)
                        }
                    }

                    List {
                        ForEach(viewModel.columns, id: \.self) { priority in
                            Text(priority.name)
                        }
                        .onDelete { _ in }
                        .onMove { _, _ in }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                    }
                    .listStyle(.plain)
                }
                .tabItem {
                    Text(Str.settingsPrioritiesLabel)
                }
                .environment(\.editMode, $viewModel.priorityEditMode)
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: .mock)
}
