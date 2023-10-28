import SwiftUI

struct SettingsView {
    @Bindable var viewModel: SettingsViewModel
}

extension SettingsView: View {
    var body: some View {
        VStack(spacing: .padding16) {
            Text(Str.settingsTitle)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            TabView {
                categoryTab
                columnTab
                priorityTab
            }
        }
    }
}

extension SettingsView {
    var categoryTab: some View {
        VStack {
            HStack {
                Spacer()
                if viewModel.categoryEditMode == .active {
                    IconButton(.add, action: viewModel.didTapNewCategory)
                }
                IconButton(.edit) {
                    EditMode.toggle(mode: &viewModel.categoryEditMode)
                }
            }

            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    HStack {
                        EditableText(item: category, isEditable: viewModel.categoryEditMode == .active) {
                            viewModel.didChangeName(of: category, to: $0)
                        }
                        Spacer()
                        Circle()
                            .sized(.defaultIconSize)
                            .foregroundStyle(Color.from(components: category.colorComponents))
                    }
                }
                .onDelete { _ in }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            }
            .listStyle(.plain)
        }
        .tabItem {
            Text(Str.settingsCategoriesLabel)
        }
        .environment(\.editMode, $viewModel.categoryEditMode)
        .sheet(isPresented: $viewModel.isNewCategorySheetPresented) {
            VStack {
                HStack {
                    Button("Cancel", role: .cancel) { viewModel.isNewCategorySheetPresented.toggle() }
                    Spacer()
                    Button("Save", action: viewModel.didTapAddCategory)
                }
                TextField(String.empty, text: $viewModel.newCategoryName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textFieldStyle(.roundedBorder)
                ColorPicker("Color", selection: $viewModel.currentColor)
                Spacer()
            }
        }
    }

    var columnTab: some View {
        VStack {
            HStack {
                Spacer()
                IconButton(.edit) {
                    EditMode.toggle(mode: &viewModel.columnEditMode)
                }
            }

            List {
                ForEach(viewModel.columns, id: \.self) { column in
                    EditableText(item: column, isEditable: viewModel.columnEditMode == .active) {
                        viewModel.didChangeName(of: column, to: $0)
                    }
                }
                .onDelete { _ in }
                .onMove(perform: viewModel.didMoveColumn)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            }
            .listStyle(.plain)

            if viewModel.columnEditMode == .active {
                HStack {
                    TextField(String.empty, text: $viewModel.newColumnName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textFieldStyle(.roundedBorder)
                    IconButton(.add, action: viewModel.didTapAddColumn)
                }
            }
        }
        .tabItem {
            Text(Str.settingsColumnsLabel)
        }
        .environment(\.editMode, $viewModel.columnEditMode)
    }

    var priorityTab: some View {
        VStack {
            HStack {
                Spacer()
                IconButton(.edit) {
                    EditMode.toggle(mode: &viewModel.priorityEditMode)
                }
            }

            List {
                ForEach(viewModel.priorities, id: \.self) { priority in
                    EditableText(item: priority, isEditable: viewModel.priorityEditMode == .active) {
                        viewModel.didChangeName(of: priority, to: $0)
                    }
                }
                .onDelete { _ in }
                .onMove(perform: viewModel.didMovePriority)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            }
            .listStyle(.plain)

            if viewModel.priorityEditMode == .active {
                HStack {
                    TextField(String.empty, text: $viewModel.newPriorityName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textFieldStyle(.roundedBorder)
                    IconButton(.add, action: viewModel.didTapAddPriority)
                }
            }
        }
        .tabItem {
            Text(Str.settingsPrioritiesLabel)
        }
        .environment(\.editMode, $viewModel.priorityEditMode)
    }
}

#Preview {
    SettingsView(viewModel: .mock)
}
