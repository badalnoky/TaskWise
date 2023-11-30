import SwiftUI

struct DashboardView {
    let viewModel: DashboardViewModel
}
// swiftlint: disable: closure_body_length
extension DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            StyledText(text: Str.dashboardTitle, style: .title)
                .padding(.horizontal, .padding8)

            StyledDate(date: viewModel.date, style: .date)
                .padding(.horizontal, .padding8)

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
                                    Text(column.name)
                                        .font(.title)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                ScrollView {
                                    ForEach(viewModel.tasks.from(column: column), id: \.id) { task in
                                        HStack {
                                            HStack {
                                                Text(task.title)
                                                    .padding()
                                                Spacer()
                                            }
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                viewModel.didTapTask(task)
                                            }
                                            Menu {
                                                Button("Delete") {
                                                    viewModel.didTapDelete(task: task)
                                                }
                                            } label: {
                                                IconButton(.more) {}
                                            }
                                            .padding()
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
        .dashboardNavigationBar(
            settingsAction: viewModel.didTapSettings,
            calendarAction: viewModel.didTapCalendar,
            addAction: viewModel.didTapAddTask
        )
        .defaultViewPadding()
    }
}

#Preview {
    DashboardView(viewModel: .mock)
}
