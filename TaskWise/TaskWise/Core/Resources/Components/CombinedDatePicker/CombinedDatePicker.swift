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
            .frame(height: .defaultRowHeight)

            if !allDay.wrappedValue {
                DatePicker(selection: starts, in: Date.now...) {
                    Text(Str.Task.startsLabel)
                        .textStyle(.body)
                }
                .tint(.appTint)
                .frame(height: .defaultRowHeight)
                .onChange(of: starts.wrappedValue) {
                    ends.wrappedValue = starts.wrappedValue.addingTimeInterval(.hour)
                }

                DatePicker(selection: ends, in: starts.wrappedValue.addingTimeInterval(.minute)..., displayedComponents: .hourAndMinute) {
                    Text(Str.Task.endsLabel)
                        .textStyle(.body)
                }
                .frame(height: .defaultRowHeight)
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
    @Previewable @State var isAllDay = false
    @Previewable @State var starts: Date = .now
    @Previewable @State var ends: Date = .now
    CombinedDatePicker(allDay: $isAllDay, starts: $starts, ends: $ends)
}
