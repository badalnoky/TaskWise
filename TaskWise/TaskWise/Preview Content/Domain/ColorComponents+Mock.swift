import SwiftUI

#if DEBUG
extension ColorComponents {
    static var mock: ColorComponents {
        let components = ColorComponents(context: PreviewDataController.global.context)
        components.wRed = Color.blue.components.red
        components.wGreen = Color.blue.components.green
        components.wBlue = Color.blue.components.blue
        components.wAlpha = Color.blue.components.alpha
        return components
    }
}
#endif
