import SwiftUI

struct CalendarView {
    @Bindable var viewModel: CalendarViewModel
}

extension CalendarView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                IconButton(.list, action: viewModel.didTapList)
                IconButton(.filter) {}
                IconButton(.search) {}
            }
            Spacer()

            DatePicker(String.empty, selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date)
                .datePickerStyle(.graphical)

            if viewModel.isListed {
                VStack {
                    HStack {
                        Color.clear.sized(.iconButtonSize)
                        Text(Str.calendarTodoLabel)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        IconButton(.add) {}
                    }
                    ScrollView {
                        ForEach(viewModel.loadedTasks, id: \.self) { task in
                            Text(task).padding()
                        }
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                Spacer()
            }
        }
    }
}

#Preview {
    CalendarView(viewModel: .mock)
}
