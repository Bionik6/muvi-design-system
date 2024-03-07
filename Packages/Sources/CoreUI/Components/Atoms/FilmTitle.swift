import SwiftUI

struct FilmTitle: View {
  let value: String

  var body: some View {
    Text(value)
      .font(CustomFont.body2)
      .foregroundStyle(ColorToken.white)
      .lineLimit(1)
  }
}

#Preview {
  BaseContentView {
    FilmTitle(value: "Spider-Man: No way home")
      .loadCustomFonts()
  }
}
