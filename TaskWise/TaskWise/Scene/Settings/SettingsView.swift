import SwiftUI

struct SettingsView {
    @Bindable var viewModel: SettingsViewModel
}

extension SettingsView: View {
    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentTab) {
                categoryTab
                columnTab
                priorityTab
            }
        }
        .defaultViewPadding()
        .settingsNavigationBar(
            isEditing: viewModel.isEditing,
            editAction: viewModel.didTapEdit,
            addAction: viewModel.didTapAdd,
            finishAction: viewModel.didFinish
        )
    }
}

extension SettingsView {
    var categoryTab: some View {
        VStack {
            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    HStack {
                        EditableText(item: category, isEditable: viewModel.categoryEditMode == .active) {
                            viewModel.didChangeName(of: category, to: $0)
                        }
                        CategoryColorPicker(category: category, isEditable: viewModel.categoryEditMode == .active) {
                            viewModel.didChangeColor(on: category, to: $0)
                        }
                    }
                    .padding(.horizontal, .padding16)
                }
                .onDelete(perform: viewModel.didTapDeleteCategory)
                .defaultListRowSettings()
            }
            .listStyle(.plain)
        }
        .tabItem { Text(Str.settingsCategoriesLabel) }
        .environment(\.editMode, $viewModel.categoryEditMode)
        .sheet(isPresented: $viewModel.isNewCategorySheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button("Cancel", role: .cancel) { viewModel.isNewCategorySheetPresented.toggle() }
                    Spacer()
                    Button("Add", action: viewModel.didTapAddCategory)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: "Category name", text: $viewModel.newCategoryName)
                ColorPicker("Color", selection: $viewModel.currentColor)
                    .textStyle(.body)
                    .padding(.horizontal, .padding4)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
        }
        .tag(SettingTabs.category)
    }

    var columnTab: some View {
        VStack {
            List {
                ForEach(viewModel.columns, id: \.self) { column in
                    EditableText(item: column, isEditable: viewModel.columnEditMode == .active) {
                        viewModel.didChangeName(of: column, to: $0)
                    }
                    .padding(.horizontal, .padding16)
                }
                .onDelete(perform: viewModel.didTapDeleteColumn)
                .onMove(perform: viewModel.didMoveColumn)
                .defaultListRowSettings()
            }
            .listStyle(.plain)
        }
        .tabItem { Text(Str.settingsColumnsLabel) }
        .environment(\.editMode, $viewModel.columnEditMode)
        .sheet(isPresented: $viewModel.isNewColumnSheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button("Cancel", role: .cancel) { viewModel.isNewColumnSheetPresented.toggle() }
                    Spacer()
                    Button("Add", action: viewModel.didTapAddColumn)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: "Column name", text: $viewModel.newColumnName)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
        }
        .tag(SettingTabs.column)
    }

    var priorityTab: some View {
        VStack {
            List {
                ForEach(viewModel.priorities, id: \.self) { priority in
                    EditableText(item: priority, isEditable: viewModel.priorityEditMode == .active) {
                        viewModel.didChangeName(of: priority, to: $0)
                    }
                    .padding(.horizontal, .padding16)
                }
                .onDelete(perform: viewModel.didTapDeletePriority)
                .onMove(perform: viewModel.didMovePriority)
                .defaultListRowSettings()
            }
            .listStyle(.plain)
        }
        .tabItem { Text(Str.settingsPrioritiesLabel) }
        .environment(\.editMode, $viewModel.priorityEditMode)
        .sheet(isPresented: $viewModel.isNewPrioritySheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button("Cancel", role: .cancel) { viewModel.isNewPrioritySheetPresented.toggle() }
                    Spacer()
                    Button("Add", action: viewModel.didTapAddPriority)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: "Priority name", text: $viewModel.newPriorityName)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
        }
        .tag(SettingTabs.priority)
    }
}

#Preview {
    SettingsView(viewModel: .mock)
}
