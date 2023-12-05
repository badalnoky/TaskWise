import SwiftUI
public struct TaskProgressIndicator {
    let done: Int
    let total: Int
    let width: Double

    var progress: Double {
        (0.6 / Double(total)) * Double(done) + 0.2
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
                .trim(from: progress, to: 0.8)
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .frame(width: width)
                .rotationEffect(.degrees(90))
                .foregroundStyle(.text.opacity(0.2))

            Circle()
                .trim(from: 0.2, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [.progress.opacity(0.1), .progress.opacity(1.6)]),
                        center: .center
                    )
                )
                .frame(width: width)
                .rotationEffect(.degrees(90))

            Text("\(done)/\(total)")
                .foregroundStyle(.accent)
                .textStyle(.title)
        }
    }
}

#Preview {
    TaskProgressIndicator(done: 15, total: 15, width: 150)
}
