import SwiftUI

#if DEBUG
extension ColorComponents {
    static var mock: ColorComponents {
        let components = ColorComponents(context: PreviewDataService.global.context)
        components.wRed = .zero
        components.wGreen = .zero
        components.wBlue = .one
        components.wAlpha = .one
        return components
    }
}
#endif
