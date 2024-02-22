import SwiftUI

enum Inter: String, CaseIterable {
  case regular = "Inter-Regular"
  case medium = "Inter-Medium"
  case semibold = "Inter-SemiBold"
  case bold = "Inter-Bold"
}

public enum CustomFont {
  public static func registerFonts() {
    Inter.allCases.forEach {
      registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }

  fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
      fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
    }

    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
  }

  private static func makeFont(_ name: Inter, size: CGFloat) -> Font {
    Font.custom(name.rawValue, size: size, relativeTo: .body)
  }

  static let heading1 = makeFont(.bold, size: 24)
  static let heading2 = makeFont(.bold, size: 20)
  static let title1 = makeFont(.semibold, size: 18)
  static let title2 = makeFont(.semibold, size: 16)
  static let title3 = makeFont(.semibold, size: 14)
  static let body1 = makeFont(.regular, size: 16)
  static let body2 = makeFont(.regular, size: 14)
  static let caption1 = makeFont(.regular, size: 12)
  static let caption2 = makeFont(.regular, size: 10)
  static let button = makeFont(.medium, size: 14)
}

extension View {
  /// Attach this to any Xcode Preview's view to have custom fonts displayed
  /// Note: Not needed for the actual app
  public func loadCustomFonts() -> some View {
    CustomFont.registerFonts()
    return self
  }
}

extension Text {

}
