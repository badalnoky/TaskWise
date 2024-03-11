import SwiftUI

struct GradientSlider {
    var value: Binding<Int>
    var type: RGBType
    @State private var indirectValue: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    private var secondColorValue: Binding<Int>
    private var thirdColorValue: Binding<Int>

    init(
        value: Binding<Int>,
        type: RGBType,
        secondColorValue: Binding<Int>,
        thirdColorValue: Binding<Int>
    ) {
        self.value = value
        self.type = type
        self.secondColorValue = secondColorValue
        self.thirdColorValue = thirdColorValue
    }
}

// swiftlint: disable: closure_body_length
extension GradientSlider: View {
    var body: some View {
        GeometryReader { geometry in
            let maxOffset = geometry.size.width - .colorSliderMinOffset - .colorSliderSize
            let range = maxOffset - .colorSliderMinOffset
            let selectedColor = Color.getColorFrom(type: type, value.wrappedValue, secondColorValue.wrappedValue, thirdColorValue.wrappedValue)

            VStack {
                HStack {
                    Circle()
                        .strokeBorder(.background, lineWidth: .baseLineWidth)
                        .shadow(color: .gray, radius: .colorSliderShadowRadius)
                        .background(Circle().fill(selectedColor))
                        .frame(width: .colorSliderSize, height: .colorSliderSize)
                        .offset(x: indirectValue < .colorSliderMinOffset ? .colorSliderMinOffset : indirectValue)
                        .gesture(
                            DragGesture(minimumDistance: .zero)
                                .onChanged { value in
                                    if abs(value.translation.width) < .minimumGestureTranslation {
                                        self.offset = self.indirectValue
                                    }
                                    if value.translation.width > .zero {
                                        withAnimation {
                                            self.indirectValue = min(maxOffset, self.offset + value.translation.width)
                                        }
                                    } else {
                                        withAnimation {
                                            self.indirectValue = max(.colorSliderMinOffset, self.offset + value.translation.width)
                                        }
                                    }
                                    self.value.wrappedValue = Int(round((self.indirectValue - .colorSliderMinOffset) / range * .maxColorValue))
                                }
                        )
                    Spacer()
                }
                .frame(maxWidth: geometry.size.width)
            }
            .frame(height: .colorSliderHeight)
            .onAppear {
                self.indirectValue = CGFloat(self.value.wrappedValue) / .maxColorValue * range + .colorSliderMinOffset
            }
            .onChange(of: value.wrappedValue) {
                withAnimation {
                    self.indirectValue = CGFloat(self.value.wrappedValue) / .maxColorValue * range + .colorSliderMinOffset
                }
            }
        }
        .background {
            Capsule().fill(LinearGradient(colors: getGradientColors(), startPoint: .leading, endPoint: .trailing))
        }
        .frame(height: .colorSliderHeight)
    }

    private func getGradientColors() -> [Color] {
        var colors = [Color]()
        for idx in .zero...Int.maxColorValue {
            colors.append(Color.getColorFrom(type: type, idx, secondColorValue.wrappedValue, thirdColorValue.wrappedValue))
        }
        return colors
    }
}
// swiftlint: enable: closure_body_length

#Preview {
    @State var value: Int = .zero
    @State var second: Int = .zero
    @State var third: Int = .zero
    return GradientSlider(value: $value, type: .red, secondColorValue: $second, thirdColorValue: $third)
}
