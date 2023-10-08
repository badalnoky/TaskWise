import SwiftUI

struct DashboardView {
    let viewModel: DashboardViewModel
}

extension DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                IconButton(.settings, action: viewModel.didTapSettings)
                Spacer()
                IconButton(.calendar, action: viewModel.didTapCalendar)
            }

            Text(Str.dashboardTitle)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewModel.date, format: .dateTime.month(.wide).day(.defaultDigits))
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            GeometryReader { geometry in
                VStack {
                    Circle()
                        .stroke(lineWidth: .indicatorBorderWidth)
                        .frame(width: geometry.size.width * 0.4)
                        .padding(.padding32)

                    TabView {
                        ForEach(TaskColumn.defaultColumns, id: \.id) { column in
                            VStack {
                                HStack {
                                    Color.clear.sized(.iconButtonSize)
                                    Text(column.name)
                                        .font(.title)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    IconButton(.add, action: viewModel.didTapAddTask)
                                }
                                ScrollView {
                                    ForEach(viewModel.tasks, id: \.id) { task in
                                        Text(task.title)
                                            .padding()
                                            .frame(width: geometry.size.width)
                                            .onTapGesture {
                                                viewModel.didTapTask()
                                            }
                                    }
                                }
                            }
                            .frame(width: geometry.size.width)
                            .padding(.bottom, .padding50)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
        }
    }
}

#Preview {
    DashboardView(viewModel: .mock)
}
