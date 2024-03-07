import SwiftUI

struct PlayFilmButton: View {
  let title: LocalizedStringResource
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack {
        Text(title)
          .font(CustomFont.button)
        Image.Icon.play
          .resizable()
          .frame(width: Constants.iconSize, height: Constants.iconSize)
      }
      .foregroundStyle(ColorToken.white)
      .frame(height: Constants.heigth)
      .padding(.horizontal, Constants.horizontalPadding)
      .background {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(ColorToken.red100)
      }
    }
  }

  enum Constants {
    static let iconSize = 14.0
    static let horizontalPadding = 16.0
    static let verticalPadding = 12.0
    static let cornerRadius = 4.0
    static let heigth = 40.0
  }
}

#Preview {
  BaseContentView {
    PlayFilmButton(title: "Play Now") {}
  }
  .loadCustomFonts()
}
