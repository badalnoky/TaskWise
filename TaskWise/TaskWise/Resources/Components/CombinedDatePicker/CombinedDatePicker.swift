import SwiftUI

public struct CombinedDatePicker {
    private var allDay: Binding<Bool>
    private var starts: Binding<Date>
    private var ends: Binding<Date>

    public init(allDay: Binding<Bool>, starts: Binding<Date>, ends: Binding<Date>) {
        self.allDay = allDay
        self.starts = starts
        self.ends = ends
    }
}

extension CombinedDatePicker: View {
    public var body: some View {
        VStack(spacing: .padding12) {
            Toggle(isOn: allDay.animation(.easeInOut)) {
                Text(Str.DatePicker.allDayLabel).textStyle(.body)
            }
            .padding(.trailing, .padding8)
            .tint(.accent)

            if !allDay.wrappedValue {
                DatePicker(selection: starts, in: Date.now...) {
                    Text(Str.Task.startsLabel)
                        .textStyle(.body)
                }
                .tint(.appTint)

                DatePicker(selection: ends, in: Date.now.addingTimeInterval(.hour)..., displayedComponents: .hourAndMinute) {
                    Text(Str.Task.endsLabel)
                        .textStyle(.body)
                }
            } else {
                DatePicker(selection: starts, in: Date.now..., displayedComponents: .date) {
                    Text(Str.DatePicker.dateLabel).textStyle(.body)
                }
            }
        }
        .padding(.horizontal, .padding4)
    }
}

#Preview {
    @State var isAllDay = false
    @State var starts: Date = .now
    @State var ends: Date = .now
    return CombinedDatePicker(allDay: $isAllDay, starts: $starts, ends: $ends)
}
