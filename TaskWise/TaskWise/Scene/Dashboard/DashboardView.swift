import SwiftUI

struct DashboardView {
    let viewModel: DashboardViewModel
}
// swiftlint: disable: closure_body_length
extension DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                IconButton(.settings, action: viewModel.didTapSettings)
                Spacer()
                IconButton(.calendar, action: viewModel.didTapCalendar)
                IconButton(.add, action: viewModel.didTapAddTask)
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
                    ZStack {
                        Circle()
                            .stroke(lineWidth: .indicatorBorderWidth)
                            .frame(width: geometry.size.width * 0.4)
                            .padding(.padding32)
                        Text(viewModel.completionText)
                            .font(.title).bold()
                    }

                    TabView {
                        ForEach(viewModel.columns, id: \.self) { column in
                            VStack {
                                HStack {
                                    Color.clear.sized(.iconButtonSize)
                                    Text(column.name)
                                        .font(.title)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                ScrollView {
                                    ForEach(viewModel.tasks.from(column: column), id: \.id) { task in
                                        HStack {
                                            Text(task.title)
                                                .padding()
                                                .onTapGesture {
                                                    viewModel.didTapTask(task)
                                            }
                                            Spacer()
                                            Menu {
                                                Button("Delete") {
                                                    viewModel.didTapDelete(task: task)
                                                }
                                            } label: {
                                                IconButton(.more) {}
                                            }
                                        }
                                        .frame(width: geometry.size.width)
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
