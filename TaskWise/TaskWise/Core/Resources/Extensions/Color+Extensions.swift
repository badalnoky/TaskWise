import SwiftUI

extension Color {
    static func from(components: ColorComponents) -> Color {
        Color(red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
}

#if !os(watchOS)
extension Color {
    var components: ColorComponents.DTO {
        #if os(macOS)
        let ciColor = CIColor(color: NSColor(self))!
        #else
        let ciColor = CIColor(color: UIColor(self))
        #endif
        return ColorComponents.DTO(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha)
    }
}
#endif
