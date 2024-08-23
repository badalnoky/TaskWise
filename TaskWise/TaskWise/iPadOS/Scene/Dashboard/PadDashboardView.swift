import SwiftUI

struct PadDashboardView: View {
    var body: some View {
        VStack {
            Text("Hello, iPad!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .padDashboardNavigationBar(
            searchAction: {},
            filterAction: {}
        )
    }
}

#Preview {
    PadDashboardView()
}
