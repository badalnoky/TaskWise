import Foundation

@Observable final class WatchDashboardViewModel {
    var selectedTab: Int = .zero
    var tasks: [String] = ["a", "b", "c", "d", "e"]
    var firstColumnName: String = "Todo"
    var allTaskCount: Int = 5
    var doneTaskCount: Int = 3
}
