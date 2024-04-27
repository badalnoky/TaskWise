import SwiftUI

public struct CompletionView {
    let done: Int
    let total: Int

    var progress: CGFloat {
        (.watchIndicatorRange / Double(total)) * Double(done) + .watchIndicatorLowerBound
    }

    public init(done: Int, total: Int) {
        self.done = done
        self.total = total
    }

    private func lineWidth(width: CGFloat) -> CGFloat {
        let relativeValue = (width - .watchIndicatorMinWidth) / .watchIndicatorWidthRange
        let projectedValue = relativeValue * .watchIndicatorLineWidthRange + .watchIndicatorMinLineWidth
        switch width {
        case ..<(.watchIndicatorMinWidth): return .watchIndicatorMinLineWidth
        case .watchIndicatorMinWidth..<(.watchIndicatorMaxWidth): return projectedValue
        case .watchIndicatorMaxWidth...: return .watchIndicatorMaxLineWidth
        default: return .watchIndicatorMinLineWidth
        }
    }

    private func dynamicFontSized(width: CGFloat) -> Font {
        let relativeValue = (width - .watchIndicatorMinWidth) / .watchIndicatorWidthRange
        let projectedValue = relativeValue * .watchIndicatorFontRange + .watchIndicatorMinFontSize
        switch width {
        case ..<(.watchIndicatorMinWidth): return .system(size: .watchIndicatorMinFontSize).bold()
        case .watchIndicatorMinWidth..<(.watchIndicatorMaxWidth): return .system(size: projectedValue).bold()
        case .watchIndicatorMaxWidth...: return .system(size: .watchIndicatorMaxFontSize).bold()
        default: return .system(size: .watchIndicatorMinFontSize).bold()
        }
    }
}

extension CompletionView: View {
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Circle()
                        .trim(from: total != .zero ? progress : .watchIndicatorLowerBound, to: .watchIndicatorGreaterBound)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth(width: geometry.size.width), lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(.watchIndicatorRotation))
                        .foregroundStyle(.white.opacity(.watchIndicatorBaseOpacity))

                    Circle()
                        .trim(from: .watchIndicatorLowerBound, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth(width: geometry.size.width), lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(
                            gradient: Gradient(colors: [.progress.opacity(.watchIndicatorLowOpacity), .progress.opacity(.watchIndicatorHighOpacity)]),
                            center: .center
                        ))
                        .rotationEffect(.degrees(.watchIndicatorRotation))

                    if geometry.size.width > .watchMinimumTextSpace {
                        if done == total || total == .zero {
                            Image.check
                                .fittedToSize(geometry.size.width / .watchIndicatorImageRatio)
                                .foregroundStyle(.progress)
                        } else {
                            Text(Str.Indicator.completion(done, total))
                                .font(dynamicFontSized(width: geometry.size.width))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    CompletionView(done: 2, total: 3)
}
