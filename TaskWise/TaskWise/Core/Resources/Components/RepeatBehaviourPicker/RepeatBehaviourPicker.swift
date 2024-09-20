import SwiftUI

struct RepeatBehaviourPicker {
    @State private var repeatFrequency: RepeatFrequency = .never
    @State private var selectedEndDate: Date = .now.endOfDay
    @State private var isCustomSheetPresented = false
    @State private var repeatUnit: RepeatUnit = .day
    @State private var unitFrequency: Int = .one
    @State private var indices: [Int] = []
    @State private var isUnitFrequencyPresented = false

    var startingDate: Date
    var repeatBehaviour: Binding<RepeatBehaviour>

    var customRepeatLabel: String {
        var tempIndices = indices
        var indicesLabel: String = .empty
        if repeatUnit != .day {
            indicesLabel = Str.RepeatBehaviorPicker.followingDays
        }
        if repeatUnit == .week {
            if tempIndices.contains(where: { $0 > Weekday.allCases.count }) {
                tempIndices = []
            }
            tempIndices.forEach {
                indicesLabel += Str.RepeatBehaviorPicker.weekdaySeparator(Weekday.allCases[$0].rawValue)
            }
            indicesLabel.removeLast(.two)
        } else if repeatUnit == .month {
            indices.forEach {
                indicesLabel += Str.RepeatBehaviorPicker.daySeparator($0)
            }
            indicesLabel.removeLast(.two)
        }
        let unitFrequencyLabel = if unitFrequency == .one {
            .space + String(Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label).dropFirst(2)) + .space
        } else {
            .space + Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label) + .space
        }
        return Str.RepeatBehaviorPicker.customRepeatLabel + unitFrequencyLabel.lowercased() + indicesLabel
    }

    init(startingDate: Date, repeatBehaviour: Binding<RepeatBehaviour>) {
        self.startingDate = startingDate
        self.repeatBehaviour = repeatBehaviour
    }
}

extension RepeatBehaviourPicker: View {
    var body: some View {
        VStack(spacing: .padding12) {
            HStack(spacing: .zero) {
                Text(Str.RepeatBehaviorPicker.repeatLabel)
                    .textStyle(.body)
                Spacer()
                Picker(String.empty, selection: $repeatFrequency) {
                    ForEach(RepeatFrequency.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
            .padding(.horizontal, .padding4)
            .frame(height: .defaultRowHeight)
            .onChange(of: repeatFrequency) {
                repeatBehaviour.wrappedValue.frequency = repeatFrequency
            }
            if repeatFrequency == .custom {
                #if !os(macOS)
                customFrequencyButton
                #else
                customFrequencyPanel
                #endif
            }
            if repeatFrequency != .never {
                endDatePicker
            }
        }
        .onAppear {
            self.repeatFrequency = repeatBehaviour.wrappedValue.frequency
            self.selectedEndDate = repeatBehaviour.wrappedValue.end
            self.repeatUnit = repeatBehaviour.wrappedValue.schedule.unit
            self.unitFrequency = repeatBehaviour.wrappedValue.schedule.unitFrequency
            self.indices = repeatBehaviour.wrappedValue.schedule.indices
        }
        .sheet(isPresented: $isCustomSheetPresented, onDismiss: validateAndCorrect) {
            customBehaviorSheet
                .background(Color.appBackground)
        }
        .neumorphic()
    }
}

extension RepeatBehaviourPicker {
    private var endDatePicker: some View {
        DatePicker(selection: $selectedEndDate, in: startingDate..., displayedComponents: .date) {
            Text(Str.RepeatBehaviorPicker.endDateLabel)
                .textStyle(.body)
            #if os(macOS)
                .frame(maxWidth: .infinity, alignment: .leading)
            #endif
        }
        .padding(.horizontal, .padding4)
        .frame(height: .defaultRowHeight)
        .onChange(of: selectedEndDate) {
            repeatBehaviour.wrappedValue.end = selectedEndDate.endOfDay
        }
    }

    // swiftlint: disable closure_body_length
    private var customFrequencyPanel: some View {
        VStack(spacing: .padding24) {
            Text(customRepeatLabel)
                .textStyle(.body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: .zero) {
                Text(Str.RepeatBehaviorPicker.frequencyLabel)
                    .textStyle(.body)
                Spacer()
                Picker(String.empty, selection: $repeatUnit) {
                    ForEach(RepeatUnit.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
            .onChange(of: repeatUnit) {
                unitFrequency = .one
                indices = []
                repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
            }

            HStack {
                Text(Str.RepeatBehaviorPicker.everyLabel)
                    .textStyle(.body)
                Spacer()
                TextField(String.empty, value: $unitFrequency, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: .columnButtonWidth)
                let unitFrequencyLabel = if unitFrequency == .one {
                    String(Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label).dropFirst(2))
                } else {
                    Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label)
                }
                Text(unitFrequencyLabel)
            }

            if repeatUnit == .week {
                weekView
            }

            if repeatUnit == .month {
                monthView
            }
        }
        .padding(.horizontal, .padding4)
    }

    private var customFrequencyButton: some View {
        Button(action: { isCustomSheetPresented = true }) {
            HStack {
                Text(customRepeatLabel)
                    .textStyle(.body)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image.next
            }
        }
        .frame(minHeight: .defaultRowHeight)
        .padding(.leading, .padding4)
        .padding(.trailing, .padding16)
    }

    private var weekView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: .weekDayCount)) {
            ForEach(Weekday.allCases) { day in
                let isSelected = indices.contains { $0 == day.index }
                Text(day.abbreviated.uppercased())
                    .foregroundStyle(isSelected ? .white : Color.text)
                    .font(.footnote)
                    .frame(maxWidth: .infinity)
                    .padding(.padding4)
                    .background {
                        RoundedRectangle(cornerRadius: .cornerRadius)
                            .fill(isSelected ? Color.accentColor : Color.clear)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
                    .onTapGesture {
                        if isSelected {
                            indices.removeAll { $0 == day.index }
                        } else {
                            indices.append(day.index)
                            indices = indices.sorted()
                        }
                    }
            }
        }
        .padding(.padding12)
        .onChange(of: indices) {
            repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
        }
    }

    private var monthView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: .weekDayCount)) {
            ForEach(.one...Int.maxMonthlyDayCount, id: \.self) { day in
                let isSelected = indices.contains { $0 == day }
                Text(Str.RepeatBehaviorPicker.dayButtonLabel(day))
                    .foregroundStyle(isSelected ? Color.white : Color.black )
                    .frame(maxWidth: .infinity)
                    .padding(.padding4)
                    .background {
                        RoundedRectangle(cornerRadius: .cornerRadius)
                            .fill(isSelected ? Color.accentColor : Color.clear)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: .cornerRadius))
                    .onTapGesture {
                        if isSelected {
                            indices.removeAll { $0 == day }
                        } else {
                            indices.append(day)
                            indices = indices.sorted()
                        }
                    }
            }
        }
        .padding(.padding12)
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
        #if !os(macOS)
        .pickerStyle(.wheel)
        #endif
        .onChange(of: unitFrequency) {
            repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
        }
    }

    private var frequencyButton: some View {
        Button(action: { isUnitFrequencyPresented.toggle() }) {
            HStack {
                Text(Str.RepeatBehaviorPicker.everyLabel)
                    .textStyle(.body)
                Spacer()
                let unitFrequencyLabel = if unitFrequency == .one {
                    String(Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label).dropFirst(2))
                } else {
                    Str.RepeatBehaviorPicker.repeatEveryLabel(unitFrequency, repeatUnit.label)
                }
                Text(unitFrequencyLabel)
            }
            .padding(.leading, .padding4)
            .padding(.trailing, .padding16)
        }
        .frame(height: .defaultRowHeight)
        .neumorphic()
    }

    private var behaviorSheetHeaderView: some View {
        VStack(spacing: .padding12) {
            HStack {
                Button(Str.RepeatBehaviorPicker.backButtonLabel) { isCustomSheetPresented = false }
                    .buttonStyle(TextButtonStyle())
                Spacer()
            }
            .padding(.top, .padding12)

            TaskRow(title: Str.RepeatBehaviorPicker.frequencyLabel, selected: $repeatUnit) {
                ForEach(RepeatUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .onChange(of: repeatUnit) {
                unitFrequency = .one
                indices = []
                repeatBehaviour.wrappedValue.schedule = .init(unit: repeatUnit, unitFrequency: unitFrequency, indices: indices)
            }

            frequencyButton
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
        #if !os(macOS)
        .frame(minWidth: UIScreen.isPhone ? .zero : .popoverWidth)
        .defaultViewPadding()
        .presentationDetents(UIScreen.isPhone ? [.medium] : [.height(.popoverMinHeight)])
        #endif
    }
}

extension RepeatBehaviourPicker {
    private func validateAndCorrect() {
        if repeatBehaviour.wrappedValue.schedule.unit != .day, repeatBehaviour.wrappedValue.schedule.indices.isEmpty {
            repeatUnit = .day
        }
    }
}

#Preview {
    @Previewable @State var behaviour: RepeatBehaviour = .empty
    @Previewable @State var startingDate: Date = .now
    RepeatBehaviourPicker(startingDate: startingDate, repeatBehaviour: $behaviour)
}
