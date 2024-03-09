import SwiftUI

struct FilmGenre: View {
  let name: String
  let imageName: String

  var body: some View {
    Image(imageName, bundle: .module)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(maxHeight: 164)
      .overlay {
        ZStack {
          Color(hex: "0F1016").opacity(0.5)
          Text(name)
            .foregroundStyle(ColorToken.white)
            .font(CustomFont.heading2)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 8.0))
  }
}

#Preview {
  BaseContentView {
    HStack {
      FilmGenre(name: "Action", imageName: "action")
      FilmGenre(name: "Drama", imageName: "drama")
    }
    .padding()
    .loadCustomFonts()
  }
}
