import SwiftUI

struct FilmHeader: View {
  let title: LocalizedStringResource
  let accessory: (title: LocalizedStringResource, onTap: () -> Void)?

  init(
    title: LocalizedStringResource,
    accessory: (title: LocalizedStringResource, onTap: () -> Void)? = nil
  ) {
    self.title = title
    self.accessory = accessory
  }

  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(title)
        .font(CustomFont.heading2)
        .foregroundStyle(ColorToken.white)
      Spacer()
      accessory.map { title, onTap in
        Button(action: onTap) {
          HStack(spacing: 4) {
            Text(title)
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
        accessory: (title: "See All", onTap: {})
      )
    }
    .padding()
  }
  .loadCustomFonts()
}
