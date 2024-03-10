import SwiftUI

extension Color {
  public init(hex: String) {
    var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    Scanner(string: cleanHexCode).scanHexInt64(&rgb)

    let redValue = Double((rgb >> 16) & 0xff) / 255.0
    let greenValue = Double((rgb >> 8) & 0xff) / 255.0
    let blueValue = Double(rgb & 0xff) / 255.0
    self.init(red: redValue, green: greenValue, blue: blueValue)
  }

  static func hex(_ value: String) -> Color {
    Color(hex: value)
  }
}
