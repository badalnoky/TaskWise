import SwiftUI

struct ColorComponents: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color {
    var components: ColorComponents {
        let ciColor = CIColor(color: UIColor(self))
        return ColorComponents(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha)
    }

    static func fromComponents(_ components: ColorComponents) -> Color {
        Color(red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
}
