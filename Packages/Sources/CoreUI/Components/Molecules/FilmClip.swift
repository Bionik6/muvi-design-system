import SwiftUI

struct FilmClip: View {
  let title: String
  let key: String

  var body: some View {
    VStack(alignment: .leading) {
      YoutubeLinkView(key: key)
      Text(title)
        .font(CustomFont.body2)
        .multilineTextAlignment(.leading)
    }
  }
}

#Preview {
  BaseContentView {
    HStack {
      FilmClip(title: "Ricky Stanicky - Official Trailer | Prime Video", key: "WXpBN_31-Cw")
      FilmClip(title: "KUNG FU PANDA 4 | Final Trailer", key: "VR3JH8tLAqI")
    }
    .padding()
    .loadCustomFonts()
  }
}
