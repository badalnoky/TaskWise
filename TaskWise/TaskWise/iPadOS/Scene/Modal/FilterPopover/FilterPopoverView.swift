import SwiftUI

struct FilterPopoverView {
    @Bindable var viewModel: FilterPopoverViewModel
    var filterText: Binding<String>
    var selectedPriority: Binding<Priority?>
    var selectedCategory: Binding<Category?>

    init(filterText: Binding<String>, selectedPriority: Binding<Priority?>, selectedCategory: Binding<Category?>) {
        self.viewModel = FilterPopoverViewModel()
        self.filterText = filterText
        self.selectedPriority = selectedPriority
        self.selectedCategory = selectedCategory
    }
}

extension FilterPopoverView: View {
    var body: some View {
        VStack(spacing: .padding12) {
            HStack {
                Button(Str.Filter.clearAllLabel, action: didTapClearFilters)
                    .buttonStyle(TextButtonStyle())
                Spacer()
            }

            StyledField(style: .base, title: Str.Calendar.searchLabel, text: filterText)

            TaskRow(title: Str.Task.priorityLabel, selected: selectedPriority) {
                Text(Str.Filter.noSelectionLabel).tag(nil as Priority?)
                ForEach(viewModel.priorities, id: \.level) {
                    Text($0.name).tag($0 as Priority?)
                }
            }

            TaskRow(title: Str.Task.categoryLabel, selected: selectedCategory) {
                Text(Str.Filter.noSelectionLabel).tag(nil as Category?)
                ForEach(viewModel.categories, id: \.self) {
                    Text($0.name).tag($0 as Category?)
                }
            }
            Spacer()
        }
        .frame(width: .popoverWidth)
        .padding(.padding32)
        .background(Color.appBackground)
    }
}

private extension FilterPopoverView {
    func didTapClearFilters() {
        selectedCategory.wrappedValue = nil
        selectedPriority.wrappedValue = nil
        filterText.wrappedValue = .empty
    }
}
