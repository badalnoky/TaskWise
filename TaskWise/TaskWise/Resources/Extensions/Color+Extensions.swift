import SwiftUI

extension Color {
    static func from(components: ColorComponents) -> Color {
        Color(red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }
}

#if !os(watchOS)
extension Color {
    var components: ColorComponents.DTO {
        let ciColor = CIColor(color: UIColor(self))
        return ColorComponents.DTO(red: ciColor.red, green: ciColor.green, blue: ciColor.blue, alpha: ciColor.alpha)
    }

    init(red: Double, green: Double, blue: Double) {
        self.init(cgColor: CGColor(red: red.normalized, green: green.normalized, blue: blue.normalized, alpha: .one))
    }

    func value(for type: RGBType) -> Int {
        switch type {
        case .red: Int(round(CIColor(color: UIColor(self)).red * .maxColorValue))
        case .green: Int(round(CIColor(color: UIColor(self)).green * .maxColorValue))
        case .blue: Int(round(CIColor(color: UIColor(self)).blue * .maxColorValue))
        }
    }

    func toHexCode() -> String {
        let color = CIColor(color: UIColor(self))
        let hexString = String(
            format: "%02X%02X%02X",
            Int(round(color.red * .maxColorValue)),
            Int(round(color.green * .maxColorValue)),
            Int(round(color.blue * .maxColorValue))
        )
        return hexString
    }
}
#endif

extension Color {
    static var basePickerColorGrid: [[Color]] {
        [
            [
                Color(red: 255.0, green: 255.0, blue: 255.0),
                Color(red: 0.0, green: 55.0, blue: 74.0),
                Color(red: 0.0, green: 77.0, blue: 101.0),
                Color(red: 1.0, green: 110.0, blue: 143.0),
                Color(red: 0.0, green: 140.0, blue: 180.0),
                Color(red: 0.0, green: 161.0, blue: 216.0),
                Color(red: 1.0, green: 199.0, blue: 252.0),
                Color(red: 82.0, green: 214.0, blue: 252.0),
                Color(red: 147.0, green: 227.0, blue: 253.0),
                Color(red: 203.0, green: 240.0, blue: 255.0)
            ],
            [
                Color(red: 235.0, green: 235.0, blue: 235.0),
                Color(red: 1.0, green: 29.0, blue: 87.0),
                Color(red: 1.0, green: 47.0, blue: 123.0),
                Color(red: 0.0, green: 66.0, blue: 169.0),
                Color(red: 0.0, green: 86.0, blue: 214.0),
                Color(red: 0.0, green: 97.0, blue: 254.0),
                Color(red: 58.0, green: 135.0, blue: 254.0),
                Color(red: 116.0, green: 167.0, blue: 255.0),
                Color(red: 167.0, green: 198.0, blue: 255.0),
                Color(red: 211.0, green: 226.0, blue: 255.0)
            ],
            [
                Color(red: 214.0, green: 214.0, blue: 214.0),
                Color(red: 17.0, green: 5.0, blue: 59.0),
                Color(red: 26.0, green: 10.0, blue: 82.0),
                Color(red: 44.0, green: 9.0, blue: 119.0),
                Color(red: 55.0, green: 26.0, blue: 148.0),
                Color(red: 77.0, green: 34.0, blue: 178.0),
                Color(red: 94.0, green: 48.0, blue: 235.0),
                Color(red: 134.0, green: 79.0, blue: 254.0),
                Color(red: 177.0, green: 140.0, blue: 254.0),
                Color(red: 217.0, green: 201.0, blue: 254.0)
            ],
            [
                Color(red: 194.0, green: 194.0, blue: 194.0),
                Color(red: 46.0, green: 6.0, blue: 61.0),
                Color(red: 69.0, green: 13.0, blue: 89.0),
                Color(red: 97.0, green: 24.0, blue: 124.0),
                Color(red: 122.0, green: 33.0, blue: 158.0),
                Color(red: 152.0, green: 42.0, blue: 188.0),
                Color(red: 190.0, green: 56.0, blue: 243.0),
                Color(red: 211.0, green: 87.0, blue: 254.0),
                Color(red: 226.0, green: 146.0, blue: 254.0),
                Color(red: 239.0, green: 202.0, blue: 255.0)
            ],
            [
                Color(red: 173.0, green: 173.0, blue: 173.0),
                Color(red: 60.0, green: 7.0, blue: 27.0),
                Color(red: 85.0, green: 16.0, blue: 41.0),
                Color(red: 121.0, green: 26.0, blue: 61.0),
                Color(red: 153.0, green: 36.0, blue: 79.0),
                Color(red: 185.0, green: 45.0, blue: 93.0),
                Color(red: 230.0, green: 59.0, blue: 122.0),
                Color(red: 238.0, green: 113.0, blue: 158.0),
                Color(red: 244.0, green: 164.0, blue: 192.0),
                Color(red: 249.0, green: 211.0, blue: 224.0)
            ],
            [
                Color(red: 153.0, green: 153.0, blue: 153.0),
                Color(red: 92.0, green: 7.0, blue: 1.0),
                Color(red: 131.0, green: 17.0, blue: 0.0),
                Color(red: 181.0, green: 26.0, blue: 0.0),
                Color(red: 226.0, green: 36.0, blue: 0.0),
                Color(red: 255.0, green: 64.0, blue: 21.0),
                Color(red: 255.0, green: 98.0, blue: 80.0),
                Color(red: 255.0, green: 140.0, blue: 130.0),
                Color(red: 255.0, green: 181.0, blue: 175.0),
                Color(red: 255.0, green: 219.0, blue: 216.0)
            ],
            [
                Color(red: 133.0, green: 133.0, blue: 133.0),
                Color(red: 90.0, green: 28.0, blue: 0.0),
                Color(red: 123.0, green: 41.0, blue: 0.0),
                Color(red: 173.0, green: 62.0, blue: 0.0),
                Color(red: 218.0, green: 81.0, blue: 0.0),
                Color(red: 255.0, green: 106.0, blue: 0.0),
                Color(red: 255.0, green: 134.0, blue: 72.0),
                Color(red: 255.0, green: 165.0, blue: 125.0),
                Color(red: 255.0, green: 197.0, blue: 171.0),
                Color(red: 255.0, green: 226.0, blue: 214.0)
            ],
            [
                Color(red: 112.0, green: 112.0, blue: 112.0),
                Color(red: 88.0, green: 51.0, blue: 0.0),
                Color(red: 122.0, green: 74.0, blue: 0.0),
                Color(red: 169.0, green: 104.0, blue: 0.0),
                Color(red: 211.0, green: 131.0, blue: 1.0),
                Color(red: 255.0, green: 171.0, blue: 1.0),
                Color(red: 254.0, green: 180.0, blue: 63.0),
                Color(red: 255.0, green: 199.0, blue: 119.0),
                Color(red: 255.0, green: 217.0, blue: 168.0),
                Color(red: 255.0, green: 236.0, blue: 212.0)
            ],
            [
                Color(red: 92.0, green: 92.0, blue: 92.0),
                Color(red: 86.0, green: 61.0, blue: 0.0),
                Color(red: 120.0, green: 88.0, blue: 0.0),
                Color(red: 166.0, green: 123.0, blue: 1.0),
                Color(red: 209.0, green: 157.0, blue: 1.0),
                Color(red: 253.0, green: 199.0, blue: 0.0),
                Color(red: 254.0, green: 203.0, blue: 62.0),
                Color(red: 255.0, green: 217.0, blue: 119.0),
                Color(red: 254.0, green: 228.0, blue: 168.0),
                Color(red: 255.0, green: 242.0, blue: 213.0)
            ],
            [
                Color(red: 71.0, green: 71.0, blue: 71.0),
                Color(red: 102.0, green: 97.0, blue: 0.0),
                Color(red: 141.0, green: 134.0, blue: 2.0),
                Color(red: 196.0, green: 188.0, blue: 0.0),
                Color(red: 245.0, green: 236.0, blue: 0.0),
                Color(red: 254.0, green: 251.0, blue: 65.0),
                Color(red: 255.0, green: 247.0, blue: 107.0),
                Color(red: 255.0, green: 249.0, blue: 148.0),
                Color(red: 255.0, green: 251.0, blue: 185.0),
                Color(red: 254.0, green: 252.0, blue: 221.0)
            ],
            [
                Color(red: 51.0, green: 51.0, blue: 51.0),
                Color(red: 79.0, green: 85.0, blue: 4.0),
                Color(red: 111.0, green: 118.0, blue: 10.0),
                Color(red: 155.0, green: 165.0, blue: 14.0),
                Color(red: 195.0, green: 209.0, blue: 23.0),
                Color(red: 217.0, green: 236.0, blue: 55.0),
                Color(red: 228.0, green: 239.0, blue: 101.0),
                Color(red: 234.0, green: 242.0, blue: 143.0),
                Color(red: 242.0, green: 247.0, blue: 183.0),
                Color(red: 247.0, green: 250.0, blue: 219.0)
            ],
            [
                Color(red: 0.0, green: 0.0, blue: 0.0),
                Color(red: 38.0, green: 62.0, blue: 15.0),
                Color(red: 56.0, green: 87.0, blue: 26.0),
                Color(red: 78.0, green: 122.0, blue: 39.0),
                Color(red: 102.0, green: 157.0, blue: 52.0),
                Color(red: 118.0, green: 187.0, blue: 64.0),
                Color(red: 150.0, green: 211.0, blue: 95.0),
                Color(red: 177.0, green: 221.0, blue: 139.0),
                Color(red: 205.0, green: 232.0, blue: 181.0),
                Color(red: 223.0, green: 238.0, blue: 212.0)
            ]
        ]
    }

    // swiftlint: disable: function_parameter_count
    static func getColorFrom(type: RGBType, _ v1: Int, _ v2: Int, _ v3: Int) -> Color {
        switch type {
        case .red: return Color( red: CGFloat(v1), green: CGFloat(v2), blue: CGFloat(v3))
        case .green: return Color( red: CGFloat(v2), green: CGFloat(v1), blue: CGFloat(v3))
        case .blue: return Color( red: CGFloat(v2), green: CGFloat(v3), blue: CGFloat(v1))
        }
    }
    // swiftlint: enable: function_parameter_count
}
