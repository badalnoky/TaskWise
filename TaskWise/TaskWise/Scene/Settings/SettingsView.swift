import SwiftUI

struct SettingsView {
    let viewModel: SettingsViewModel
}

extension SettingsView: View {
    var body: some View {
        VStack(spacing: .padding16) {
            Text(Str.settingsTitle)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            HStack {
                Text(Str.settingsCategoriesLabel)
                    .font(.headline)
                Spacer()
                IconButton(.add) {}
            }

            ScrollView {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category)
                }
            }

            HStack {
                Text(Str.settingsColumnsLabel)
                    .font(.headline)
                Spacer()
                IconButton(.add) {}
            }

            ScrollView {
                ForEach(viewModel.columns, id: \.self) { column in
                    Text(column)
                }
            }

            HStack {
                Text(Str.settingsPrioritiesLabel)
                    .font(.headline)
                Spacer()
                IconButton(.add) {}
            }

            ScrollView {
                ForEach(viewModel.priorities, id: \.self) { priority in
                    Text(priority)
                }
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: .mock)
}