import SwiftUI

struct SettingsView {
    private typealias Txt = Str.Settings

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
        .settingsNavigationBar(
            isEditing: viewModel.isEditing,
            editAction: viewModel.didTapEdit,
            addAction: viewModel.didTapAdd,
            finishAction: viewModel.didFinish
        )
        .alert(viewModel.alertMessage, isPresented: $viewModel.isAlertPresented) {
            Button(Str.Alert.ok, role: .cancel) {}
        }
    }
}

extension SettingsView {
    var categoryTab: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.categories, id: \.self) { category in
                    ListItemView(
                        isEditable: viewModel.categoryEditMode == .active,
                        deleteAction: { viewModel.didTapDeleteCategory(category) }
                    ) {
                        HStack {
                            EditableText(item: category, isEditable: viewModel.categoryEditMode == .active) {
                                viewModel.didChangeName(of: category, to: $0)
                            }
                            Spacer()
                            CategoryColorPicker(category: category, isEditable: viewModel.categoryEditMode == .active) {
                                viewModel.didChangeColor(on: category, to: $0)
                            }
                            .padding(.horizontal, .padding8)
                        }
                        .padding(.horizontal, .padding8)
                    }
                }
            }
            .defaultViewPadding()
        }
        .tabItem {
            Label(Txt.categoriesLabel, systemImage: Str.Icons.tag)
        }
        .environment(\.editMode, $viewModel.categoryEditMode)
        .sheet(isPresented: $viewModel.isNewCategorySheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button(Txt.cancelLabel, role: .cancel, action: viewModel.closeSheet)
                        .buttonStyle(TextButtonStyle())
                    Spacer()
                    Button(Txt.addLabel, action: viewModel.didTapAddCategory)
                        .buttonStyle(TextButtonStyle())
                        .disabled(viewModel.isAddDisabled)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: Txt.categoryPlaceholder, text: $viewModel.newCategoryName)
                ColorPicker(Txt.colorLabel, selection: $viewModel.currentColor)
                    .textStyle(.body)
                    .padding(.horizontal, .padding4)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
            .background(Color.appBackground)
        }
        .tag(SettingTabs.category)
        .background(Color.appBackground)
    }

    var columnTab: some View {
        ScrollView {
            VStack {
                ReorderableList(
                    highLabel: Txt.firstLabel,
                    lowLabel: Txt.lastLabel,
                    isEditable: viewModel.columnEditMode == .active,
                    items: viewModel.columns,
                    deleteAction: { viewModel.didTapDeleteColumn($0) },
                    moveAction: viewModel.didMoveColumn
                ) { column in
                    EditableText(item: column, isEditable: viewModel.columnEditMode == .active) {
                        viewModel.didChangeName(of: column, to: $0)
                    }
                    .padding(.horizontal, .padding16)
                }
                .defaultViewPadding()
            }
        }
        .tabItem {
            Label(Txt.columnsLabel, image: .column)
        }
        .environment(\.editMode, $viewModel.columnEditMode)
        .sheet(isPresented: $viewModel.isNewColumnSheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button(Txt.cancelLabel, role: .cancel, action: viewModel.closeSheet)
                        .buttonStyle(TextButtonStyle())
                    Spacer()
                    Button(Txt.addLabel, action: viewModel.didTapAddColumn)
                        .buttonStyle(TextButtonStyle())
                        .disabled(viewModel.isAddDisabled)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: Txt.columnPlaceholder, text: $viewModel.newColumnName)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
            .background(Color.appBackground)
        }
        .tag(SettingTabs.column)
        .background(Color.appBackground)
    }

    var priorityTab: some View {
        ScrollView {
            VStack {
                ReorderableList(
                    highLabel: Txt.highLabel,
                    lowLabel: Txt.lowLabel,
                    isEditable: viewModel.priorityEditMode == .active,
                    items: viewModel.priorities,
                    deleteAction: { viewModel.didTapDeletePriority($0) },
                    moveAction: viewModel.didMovePriority(source:destination:)
                ) { priority in
                    EditableText(item: priority, isEditable: viewModel.priorityEditMode == .active) {
                        viewModel.didChangeName(of: priority, to: $0)
                    }
                    .padding(.horizontal, .padding16)
                }
                .defaultViewPadding()
            }
        }
        .tabItem {
            Label(Txt.prioritiesLabel, systemImage: Str.Icons.flag)
        }
        .environment(\.editMode, $viewModel.priorityEditMode)
        .sheet(isPresented: $viewModel.isNewPrioritySheetPresented) {
            VStack(spacing: .padding24) {
                HStack {
                    Button(Txt.cancelLabel, role: .cancel, action: viewModel.closeSheet)
                        .buttonStyle(TextButtonStyle())
                    Spacer()
                    Button(Txt.addLabel, action: viewModel.didTapAddPriority)
                        .buttonStyle(TextButtonStyle())
                        .disabled(viewModel.isAddDisabled)
                }
                .padding(.top, .padding12)
                .padding(.horizontal, .padding4)
                StyledField(style: .base, title: Txt.priorityPlaceholder, text: $viewModel.newPriorityName)
                Spacer()
            }
            .presentationDetents([.height(.defaultFilterSheetHeight)])
            .defaultViewPadding()
            .background(Color.appBackground)
        }
        .tag(SettingTabs.priority)
        .background(Color.appBackground)
    }
}

#Preview {
    SettingsView(viewModel: .mock)
}
