import SwiftUI

struct RectangularCompletionView: View {
    var entry: CompletionProvider.Entry

    var progress: CGFloat {
        (.indicatorRange / Double(entry.totalTasks)) * Double(entry.completedTasks) + .indicatorLowerBound
    }

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .trim(from: .indicatorLowerBound, to: .indicatorGreaterBound)
                    .stroke(style: StrokeStyle(lineWidth: .indicitorWidgetRectangularWidth, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(.indicatorRotation))
                    .foregroundStyle(.white.opacity(.midOpacity))

                Circle()
                    .trim(from: .indicatorLowerBound, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: .indicitorWidgetRectangularWidth, lineCap: .round, lineJoin: .round))
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
            .sized(.indicatorWidgetSize)
            .padding(.trailing, .padding8)

            VStack(alignment: .leading) {
                Text(entry.date, format: .dateTime.month(.twoDigits).day().weekday(.abbreviated)).bold()
                Text(Str.Watch.Widget.today(entry.totalTasks)).font(.caption)
                Text(Str.Watch.Widget.done(entry.completedTasks)).font(.caption)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.padding4)
    }
}
