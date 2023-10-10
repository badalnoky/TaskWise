import SwiftUI

extension Color {
    var components: ColorComponents.DTO {
        let ciColor = CIColor(color: UIColor(self))
        return ColorComponents.DTO(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha)
    }

    static func from(components: ColorComponents) -> Color {
        Color(red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
}
