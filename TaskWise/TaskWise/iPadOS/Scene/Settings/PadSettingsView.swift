import IntegratedColorPicker
import SwiftUI

struct PadSettingsView {
    private typealias Txt = Str.Settings

    @Bindable var viewModel: PadSettingsViewModel

    init() {
        self.viewModel = PadSettingsViewModel()
    }
}

extension PadSettingsView: View {
    var body: some View {
        HStack(spacing: .padding32) {
            categoryColumn
            VStack(spacing: .padding32) {
                columnColumn
                priorityColumn
            }
        }
        .padding(.padding32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
    }
}

extension PadSettingsView {
    var categoryColumnHeader: some View {
        HStack(spacing: .padding24) {
            StyledText(text: Txt.categoriesLabel, style: .title)
            Spacer()
            IconButton(.add, action: viewModel.didTapNewCategory)
            IconButton(.edit, action: viewModel.didTapEditCategory)
        }
        .padding(.horizontal, .padding16)
    }

    var categoryColumn: some View {
        VStack {
            categoryColumnHeader
            ScrollView {
                VStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        ListItemView(
                            isEditable: viewModel.isEditingCategory,
                            deleteAction: { viewModel.didTapDeleteCategory(category) }
                        ) {
                            HStack {
                                EditableText(item: category, isEditable: viewModel.isEditingCategory) {
                                    viewModel.didChangeName(of: category, to: $0)
                                }
                                Spacer()
                                CategoryColorPicker(category: category, isEditable: viewModel.isEditingCategory) {
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
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $viewModel.isNewCategorySheetPresented) {
            newCategorySheet
        }
    }

    var newCategorySheet: some View {
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
            HStack {
                StyledText(text: Txt.colorLabel, style: .base)
                Spacer()
                IntegratedColorPicker(selectedColor: $viewModel.currentColor, isEditable: true) {
                    TaskItemView(
                        title: Txt.exampleTitle,
                        priority: Txt.examplePriority,
                        category: viewModel.newCategoryName,
                        categoryColor: viewModel.currentColor
                    )
                }
            }
            .padding(.horizontal, .padding4)
        }
        .frame(width: .popoverWidth)
        .padding(.padding32)
        .background(Color.appBackground)
        .onDisappear(perform: viewModel.closeSheet)
    }

    var columnColumnHeader: some View {
        HStack(spacing: .padding24) {
            StyledText(text: Txt.columnsLabel, style: .title)
            Spacer()
            IconButton(.add, action: viewModel.didTapNewColumn)
            IconButton(.edit, action: viewModel.didTapEditColumn)
        }
        .padding(.horizontal, .padding16)
    }

    var columnColumn: some View {
        VStack {
            columnColumnHeader

            ScrollView {
                VStack {
                    OrderIndicatedList(
                        highLabel: Txt.firstLabel,
                        lowLabel: Txt.lastLabel,
                        isEditable: viewModel.isEditingColumn,
                        items: viewModel.columns,
                        deleteAction: { viewModel.didTapDeleteColumn($0) },
                        moveAction: viewModel.didMoveColumn
                    ) { column in
                        EditableText(item: column, isEditable: viewModel.isEditingColumn) {
                            viewModel.didChangeName(of: column, to: $0)
                        }
                        .padding(.horizontal, .padding16)
                    }
                }
                .defaultViewPadding()
            }
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $viewModel.isNewColumnSheetPresented) {
            newColumnSheet
        }
    }

    var newColumnSheet: some View {
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
        }
        .frame(width: .popoverWidth)
        .padding(.padding32)
        .background(Color.appBackground)
        .onDisappear(perform: viewModel.closeSheet)
    }

    var priorityColumnHeader: some View {
        HStack(spacing: .padding24) {
            StyledText(text: Txt.prioritiesLabel, style: .title)
            Spacer()
            IconButton(.add, action: viewModel.didTapNewPriority)
            IconButton(.edit, action: viewModel.didTapEditPriority)
        }
        .padding(.horizontal, .padding16)
    }

    var priorityColumn: some View {
        VStack {
            priorityColumnHeader

            ScrollView {
                VStack {
                    OrderIndicatedList(
                        highLabel: Txt.highLabel,
                        lowLabel: Txt.lowLabel,
                        isEditable: viewModel.isEditingPriority,
                        items: viewModel.priorities,
                        deleteAction: { viewModel.didTapDeletePriority($0) },
                        moveAction: viewModel.didMovePriority
                    ) { priority in
                        EditableText(item: priority, isEditable: viewModel.isEditingPriority) {
                            viewModel.didChangeName(of: priority, to: $0)
                        }
                        .padding(.horizontal, .padding16)
                    }
                }
                .defaultViewPadding()
            }
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $viewModel.isNewPrioritySheetPresented) {
            newPrioritySheet
        }
    }

    var newPrioritySheet: some View {
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
        }
        .frame(width: .popoverWidth)
        .padding(.padding32)
        .background(Color.appBackground)
        .onDisappear(perform: viewModel.closeSheet)
    }
}

#Preview {
    PadSettingsView()
}
