import SwiftUI

public struct TaskProgressWidgetIndicator: View {
    let done: Int
    let total: Int

    var progress: CGFloat {
        (.indicatorRange / Double(total)) * Double(done) + .indicatorLowerBound
    }

    public var body: some View {
        ZStack {
            Circle()
                .trim(from: total != .zero ? progress : .indicatorLowerBound, to: .indicatorGreaterBound)
                .stroke(style: StrokeStyle(lineWidth: .widgetIndicatorWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(.indicatorRotation))
                .foregroundStyle(.black)

            Circle()
                .trim(from: .indicatorLowerBound, to: progress)
                .stroke(style: StrokeStyle(lineWidth: .widgetIndicatorWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(.indicatorRotation))
                .foregroundStyle(.white)

            if done == total || total == .zero {
                Image.check
                    .resizable()
                    .padding(.padding12)
            } else {
                Text(Str.Indicator.completion(done, total)).font(.system(size: .widgetFontSize)).bold()
            }
        }
    }
}

#Preview {
    TaskProgressWidgetIndicator(done: 1, total: 3)
}
