import SwiftUI

struct ComponentSlider: View {
    let type: RGBType
    var value: Binding<Int>
    var secondValue: Binding<Int>
    var thirdValue: Binding<Int>
    var body: some View {
        VStack(alignment: .leading, spacing: .componentSliderSpacing) {
            Text(type.rawValue)
                .font(.caption)
                .bold()
                .foregroundStyle(.gray)
            HStack {
                GradientSlider(value: value, type: type, secondColorValue: secondValue, thirdColorValue: thirdValue)
                TextField(String.empty, value: value, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .frame(width: .colorValueTextfieldWidth)
                    .multilineTextAlignment(.center)
                    .onChange(of: value.wrappedValue) {
                        if value.wrappedValue < .zero {
                            value.wrappedValue = .zero
                        }
                        if value.wrappedValue > .maxColorValue {
                            value.wrappedValue = .maxColorValue
                        }
                    }
            }
        }
    }
}

#Preview {
    @State var redValue: Int = .zero
    @State var greenValue: Int = .zero
    @State var blueValue: Int = .zero
    return ComponentSlider(type: .red, value: $redValue, secondValue: $greenValue, thirdValue: $blueValue)
}
