import SwiftUI

struct PadNavigator: View {
    private typealias Txt = Str.Pad.Navigation

    var body: some View {
        TabView {
            NavigationStack {
                PadDashboardView()
            }
            .tabItem {
                Label(Txt.dashboardLabel, systemImage: Txt.dashboardIcon)
            }

            NavigationStack {
                PadSettingsView()
            }
            .tabItem {
                Label(Txt.settingsLabel, systemImage: Txt.settingsIcon)
            }
        }
        .tabViewStyle(.tabBarOnly)
    }
}
#Preview {
    PadNavigator()
}
