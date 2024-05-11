import SwiftUI

struct CircularCompletionView: View {
    var entry: CompletionProvider.Entry

    var progress: CGFloat {
        (.indicatorRange / Double(entry.totalTasks)) * Double(entry.completedTasks) + .indicatorLowerBound
    }

    var body: some View {
        ZStack {
            Circle()
                .trim(from: .indicatorLowerBound, to: .indicatorGreaterBound)
                .stroke(style: StrokeStyle(lineWidth: .indicitorWidgetCircularWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(.indicatorRotation))
                .foregroundStyle(.white.opacity(.midOpacity))

            Circle()
                .trim(from: .indicatorLowerBound, to: progress)
                .stroke(style: StrokeStyle(lineWidth: .indicitorWidgetCircularWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(.indicatorRotation))
                .foregroundStyle(.appTint)

            if entry.completedTasks == entry.totalTasks || entry.totalTasks == .zero {
                Image.check
                    .resizable()
                    .padding(.padding8)
                    .foregroundStyle(.appTint)
            } else {
                Text(Str.Indicator.completion(entry.completedTasks, entry.totalTasks))
            }
        }
    }
}
