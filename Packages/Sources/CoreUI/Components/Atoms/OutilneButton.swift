import SwiftUI

struct OutilneButton: View {
  let title: LocalizedStringKey
  let action: () -> Void

  init(
    title: LocalizedStringKey,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.action = action
  }

  var body: some View {
    Button(action: action, label: {
      Label(title: { Text(title) }, icon: { Image.Icon.plus })
        .font(CustomFont.button)
        .foregroundStyle(ColorToken.red100)
        .frame(height: Constants.height)
        .frame(maxWidth: .infinity)
        .overlay(
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(ColorToken.red100, lineWidth: Constants.lineWidth)
        )
    })
  }

  private enum Constants {
    static let lineWidth = 1.0
    static let cornerRadius = 4.0
    static let height = 40.0
  }
}

#Preview {
  BaseContentView {
    OutilneButton(title: "Watchlist", action: {})
      .padding()
      .loadCustomFonts()
  }
}
