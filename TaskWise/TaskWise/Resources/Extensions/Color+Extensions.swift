import SwiftUI

extension Color {
    var components: ColorComponents {
        let ciColor = CIColor(color: UIColor(self))
        let components = ColorComponents()
        components.wRed = ciColor.red
        components.wGreen = ciColor.green
        components.wBlue = ciColor.blue
        components.wAlpha = ciColor.alpha
        return components
    }

    static func fromComponents(_ components: ColorComponents) -> Color {
        Color(red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
}
