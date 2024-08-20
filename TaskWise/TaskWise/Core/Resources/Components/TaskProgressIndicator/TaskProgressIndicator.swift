import SwiftUI
public struct TaskProgressIndicator {
    let done: Int
    let total: Int
    let width: Double

    var progress: CGFloat {
        (.indicatorRange / Double(total)) * Double(done) + .indicatorLowerBound
    }

    init(done: Int, total: Int, width: Double) {
        self.done = done
        self.total = total
        self.width = width
    }
}

extension TaskProgressIndicator: View {
    public var body: some View {
        ZStack {
            Circle()
                .trim(from: total != .zero ? progress : .indicatorLowerBound, to: .indicatorGreaterBound)
                .stroke(style: StrokeStyle(lineWidth: .indicatorBorderWidth, lineCap: .round, lineJoin: .round))
                .frame(width: width)
                .rotationEffect(.degrees(.indicatorRotation))
                .foregroundStyle(.text.opacity(.indicatorBaseOpacity))
                .background {
                    Circle()
                        .trim(from: .indicatorLowerBound, to: .indicatorGreaterBound)
                        .stroke(style: StrokeStyle(lineWidth: .shadowLineWidth, lineCap: .round, lineJoin: .round))
                        .frame(width: width)
                        .rotationEffect(.degrees(.indicatorRotation))
                        .foregroundStyle(.appBackground)
                }
                .edgeShadows()

            Circle()
                .trim(from: .indicatorLowerBound, to: progress)
                .stroke(style: StrokeStyle(lineWidth: .indicatorBorderWidth, lineCap: .round, lineJoin: .round))
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [.progress.opacity(.indicatorLowOpacity), .progress.opacity(.indicatorHighOpacity)]),
                        center: .center
                    )
                )
                .frame(width: width)
                .rotationEffect(.degrees(.indicatorRotation))

            Text(Str.Indicator.completion(done, total))
                .foregroundStyle(.accent)
                .textStyle(.title)
        }
    }
}

#Preview {
    TaskProgressIndicator(done: 15, total: 15, width: 150)
}
