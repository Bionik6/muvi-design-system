import SwiftUI

struct FilmHeader: View {
  let title: LocalizedStringResource
  let onRightButtonTapped: (() -> Void)?

  init(
    title: LocalizedStringResource,
    onRightButtonTapped: (() -> Void)? = nil
  ) {
    self.title = title
    self.onRightButtonTapped = onRightButtonTapped
  }

  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(title)
        .font(CustomFont.heading2)
        .foregroundStyle(ColorToken.white)
      Spacer()
      onRightButtonTapped.map {
        Button(action: $0) {
          HStack(spacing: 4) {
            Text("See All")
            Image(systemName: "chevron.right")
          }
          .font(CustomFont.button)
          .foregroundStyle(ColorToken.red100)
        }
      }
    }
  }
}

#Preview {
  ZStack {
    ColorToken.blackBg100.ignoresSafeArea()
    VStack {
      FilmHeader(title: "Latest release")
      Divider()
      FilmHeader(
        title: "Latest release",
        onRightButtonTapped: {}
      )
    }
    .padding()
  }
  .loadCustomFonts()
}
