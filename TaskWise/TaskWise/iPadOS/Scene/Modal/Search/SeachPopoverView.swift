import SwiftUI

struct SearchPopoverView {
    @Bindable var viewModel: SearchPopoverViewModel

    init(didTapTaskAction: @escaping (TWTask) -> Void) {
        self.viewModel = SearchPopoverViewModel(didTapTaskAction: didTapTaskAction)
    }
}

extension SearchPopoverView: View {
    var body: some View {
        VStack {
            HStack {
                StyledField(style: .base, title: Str.Calendar.searchLabel, text: $viewModel.searchText)
            }
            ScrollView {
                ForEach(viewModel.foundDates, id: \.self) { date in
                    VStack {
                        StyledDate(date: date, style: .listDate)
                        Divider()
                        ForEach(viewModel.foundTasks.from(date: date), id: \.id) { task in
                            Button(task.title) {
                                viewModel.didTapTaskAction(task)
                            }
                            .buttonStyle(ListButtonStyle(color: .from(components: task.category.colorComponents)))
                        }
                    }
                    .padding(.vertical, .padding8)
                }
            }
        }
        .frame(width: .popoverWidth, height: .popoverWidth)
        .padding(.padding32)
        .background(Color.appBackground)
    }
}
