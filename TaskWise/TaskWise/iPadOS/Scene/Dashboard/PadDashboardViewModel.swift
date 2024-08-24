import Combine
import Resolver
import SwiftUI

@Observable final class PadDashboardViewModel {
    var selectedDate: Date = .now
    var columns = ["TODO", "In Progress", "Done"]
}
