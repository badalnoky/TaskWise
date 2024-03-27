import SwiftUI

struct RepeatBehaviourPicker {
    @State private var repeatFrequency: RepeatFrequency = .never
    @State private var repeatEnd: RepeatEnd = .never
    @State private var selectedEndDate: Date = .now
    @State private var isCustomSheetPresented = false
    @State private var repeatUnit: RepeatUnit = .day
    @State private var unitFrequency: Int = .one
    @State private var indices: [Int] = []
    @State private var isUnitFrequencyPresented = false

    var startingDate: Date
    var repeatBehaviour: Binding<RepeatBehaviour>

    var customRepeatLabel: String {
        var indicesLabel: String = .empty
        if repeatUnit != .day {
            indicesLabel = Str.RepeatBehaviorPicker.followingDays
        }
        if repeatUnit == .week {
            indices.forEach {
                indicesLabel += Str.RepeatBehaviorPicker.weekdaySeparator(Weekday.allCases[$0].rawValue)
            }
            indicesLabel.removeLast(.two)
        } else if repeatUnit == .month {
            indices.forEach {
                indicesLabel += Str.RepeatBehaviorPicker.daySeparator($0)
            }
            indicesLabel.removeLast(.two)
        }
        return Str.RepeatBehaviorPicker.customRepeatLabel(unitFrequency, repeatUnit.rawValue) + indicesLabel
    }

    init(startingDate: Date, repeatBehaviour: Binding<RepeatBehaviour>) {
        self.startingDate = startingDate
        self.repeatBehaviour = repeatBehaviour
    }
}

extension RepeatBehaviourPicker: View {
    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                Text(Str.RepeatBehaviorPicker.repeatLabel)
                Spacer()
                Picker(String.empty, selection: $repeatFrequency) {
                    ForEach(RepeatFrequency.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .onChange(of: repeatFrequency) {
                    repeatBehaviour.wrappedValue.frequency = repeatFrequency
                }
            }
            if repeatFrequency == .custom {
                customFrequencyButton
            }
            if repeatFrequency != .never {
                endBehaviorPicker
            }
            if repeatEnd != .never {
                endDatePicker
            }
        }
        .sheet(isPresented: $isCustomSheetPresented) {
            customBehaviorSheet
        }
    }
}

extension RepeatBehaviourPicker {
    private var endBehaviorPicker: some View {
        HStack(spacing: .zero) {
            Text(Str.RepeatBehaviorPicker.endRepeatLabel)
            Spacer()
            Picker(String.empty, selection: $repeatEnd) {
                ForEach(RepeatEnd.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: repeatEnd) {
                repeatBehaviour.wrappedValue.endBehaviour = repeatEnd
            }
        }
    }

    private var endDatePicker: some View {
        HStack(spacing: .zero) {
            Text(Str.RepeatBehaviorPicker.endDateLabel)
            Spacer()
            DatePicker(
                String.empty,
                selection: $selectedEndDate,
                in: .now...,
                displayedComponents: .date
            )
            .onChange(of: selectedEndDate) {
                repeatBehaviour.wrappedValue.end = selectedEndDate
            }
        }
    }

    private var customFrequencyButton: some View {
        Button(action: { isCustomSheetPresented = true }) {
            HStack {
                Text(customRepeatLabel)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image.next
            }
        }
    }

    private var weekView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: .weekDayCount)) {
            ForEach(Weekday.allCases) { day in
                let isSelected = indices.contains { $0 == day.index }
                Button(day.abbreviated.uppercased()) {
                    if isSelected {
                        indices.removeAll { $0 == day.index }
                    } else {
                        indices.append(day.index)
                        indices = indices.sorted()
                    }
                }
                .foregroundStyle(.black)
                .font(.footnote)
                .frame(maxWidth: .infinity)
                .padding(.padding4)
                .background {
                    Rectangle()
                        .fill(isSelected ? Color.accentColor : Color.clear)
                }
            }
        }
        .onChange(of: indices) {
            repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
        }
    }

    private var monthView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: .weekDayCount)) {
            ForEach(.one...Int.maxMonthlyDayCount, id: \.self) { day in
                let isSelected = indices.contains { $0 == day }
                Button(Str.RepeatBehaviorPicker.dayButtonLabel(day)) {
                    if isSelected {
                        indices.removeAll { $0 == day }
                    } else {
                        indices.append(day)
                        indices = indices.sorted()
                    }
                }
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.padding4)
                .background {
                    Rectangle()
                        .fill(isSelected ? Color.accentColor : Color.clear)
                }
            }
        }
        .onChange(of: indices) {
            repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
        }
    }

    private var unitFrequencyPickerView: some View {
        Picker(String.empty, selection: $unitFrequency) {
            switch repeatUnit {
            case .day:
                ForEach(.one...Int.weekDayCount.previous, id: \.self) {
                    Text($0, format: .number)
                }
            case .week:
                ForEach(.one...Int.yearWeekCount.previous, id: \.self) {
                    Text($0, format: .number)
                }
            case .month:
                ForEach(.one...Int.yearMonthCount.previous, id: \.self) {
                    Text($0, format: .number)
                }
            }
        }
        .pickerStyle(.wheel)
        .onChange(of: unitFrequency) {
            repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
        }
    }

    private var behaviorSheetHeaderView: some View {
        VStack {
            HStack(spacing: .zero) {
                Button(Str.RepeatBehaviorPicker.backButtonLabel) { isCustomSheetPresented = false }
                Spacer()
            }
            HStack(spacing: .zero) {
                Text(Str.RepeatBehaviorPicker.frequencyLabel)
                Spacer()
                Picker(String.empty, selection: $repeatUnit) {
                    ForEach(RepeatUnit.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .onChange(of: repeatUnit) {
                    unitFrequency = .one
                    indices = []
                    repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
                }
            }
            Button(action: { isUnitFrequencyPresented.toggle() }) {
                HStack {
                    Text(Str.RepeatBehaviorPicker.everyLabel)
                        .foregroundStyle(.black)
                    Spacer()
                    Text(Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.rawValue))
                }
            }
        }
    }

    private var customBehaviorSheet: some View {
        VStack {
            behaviorSheetHeaderView
            if isUnitFrequencyPresented {
                unitFrequencyPickerView
            }
            if repeatUnit == .week {
                weekView
            }
            if repeatUnit == .month {
                monthView
            }
            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
}

#Preview {
    @State var behaviour: RepeatBehaviour = .empty
    @State var startingDate: Date = .now
    return RepeatBehaviourPicker(startingDate: startingDate, repeatBehaviour: $behaviour)
}
