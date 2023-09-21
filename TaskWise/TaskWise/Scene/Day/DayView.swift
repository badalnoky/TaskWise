import SwiftUI

struct DayView {
    let viewModel: DayViewModel
}

extension DayView: View {
    var body: some View {
        VStack {
            Text(viewModel.date, format: .dateTime.year().month().day(.defaultDigits))
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewModel.date, format: .dateTime.weekday(.wide))
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Color.clear.sized(.iconButtonSize)
                Text(Str.dayTodoLabel)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                IconButton(.add) {}
            }
            ScrollView {
                ForEach(viewModel.tasks, id: \.self) { task in
                    Text(task)
                        .padding()
                        .onTapGesture {
                            viewModel.didTapTask(task)
                        }
                }
            }
        }
    }
}

#Preview {
    DayView(viewModel: .mock)
}
