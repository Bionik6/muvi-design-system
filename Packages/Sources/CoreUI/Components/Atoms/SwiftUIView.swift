import SwiftUI

public struct Paragraph: View {
  let text: String

  public init(text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(CustomFont.body2)
      .lineSpacing(6)
  }
}

#Preview {
  BaseContentView {
    Paragraph(
      text: "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man."
    )
    .padding()
    .loadCustomFonts()
  }
}
