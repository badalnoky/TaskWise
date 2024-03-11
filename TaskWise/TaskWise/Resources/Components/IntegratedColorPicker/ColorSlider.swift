import SwiftUI

struct ColorSlider {
    var selectedColor: Binding<Color>
    @State private var redValue: Int
    @State private var greenValue: Int
    @State private var blueValue: Int
    @State private var hexCode: String
    @FocusState private var isTextFieldFocused: Bool

    init(selectedColor: Binding<Color>) {
        self.selectedColor = selectedColor
        self.redValue = selectedColor.wrappedValue.value(for: .red)
        self.greenValue = selectedColor.wrappedValue.value(for: .green)
        self.blueValue = selectedColor.wrappedValue.value(for: .blue)
        self.hexCode = selectedColor.wrappedValue.toHexCode()
    }
}

extension ColorSlider: View {
    var body: some View {
        VStack(spacing: .colorSliderSpacing) {
            ComponentSlider(type: .red, value: $redValue, secondValue: $greenValue, thirdValue: $blueValue)
            ComponentSlider(type: .green, value: $greenValue, secondValue: $redValue, thirdValue: $blueValue)
            ComponentSlider(type: .blue, value: $blueValue, secondValue: $redValue, thirdValue: $greenValue)
            HStack {
                Spacer()
                Text(String.colorHexCodeLabel)
                TextField(String.empty, text: $hexCode)
                    .focused($isTextFieldFocused)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .frame(width: .hexCodeTextfieldWidth)
                    .onChange(of: hexCode) { oldValue, newValue in
                        hexCode = hexCode.trimmingCharacters(in: .whitespacesAndNewlines)
                        hexCode = hexCode.replacingOccurrences(of: String.hashMark, with: String.empty)
                        hexCode = hexCode.uppercased()
                        if hexCode.count > .maxHexCodeDigits {
                            hexCode = String(Array(hexCode)[.zero..<Int.maxHexCodeDigits])
                        } else if oldValue.count < newValue.count, !NSPredicate(format: .regex, String.hexCodeRegex).evaluate(with: hexCode) {
                            hexCode = oldValue
                        }
                        if isTextFieldFocused {
                            hexCode.hexTranslate(red: &redValue, green: &greenValue, blue: &blueValue)
                        }
                    }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .aspectRatio(.colorPickerAspectRatio, contentMode: .fit)
        .onChange(of: redValue) {
            selectedColor.wrappedValue = Color(red: Double(redValue), green: Double(greenValue), blue: Double(blueValue))
            if !isTextFieldFocused {
                hexCode = selectedColor.wrappedValue.toHexCode()
            }
        }
        .onChange(of: greenValue) {
            selectedColor.wrappedValue = Color(red: Double(redValue), green: Double(greenValue), blue: Double(blueValue))
            if !isTextFieldFocused {
                hexCode = selectedColor.wrappedValue.toHexCode()
            }
        }
        .onChange(of: blueValue) {
            selectedColor.wrappedValue = Color(red: Double(redValue), green: Double(greenValue), blue: Double(blueValue))
            if !isTextFieldFocused {
                hexCode = selectedColor.wrappedValue.toHexCode()
            }
        }
    }
}

#Preview {
    @State var color = Color.blue
    return ColorSlider(selectedColor: $color)
}
