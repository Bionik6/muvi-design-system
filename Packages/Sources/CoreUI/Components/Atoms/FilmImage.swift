import SwiftUI

struct FilmImage: View {
  let posterPath: String
  let isHighDefinition: Bool

  init(
    posterPath: String,
    isHighDefinition: Bool
  ) {
    self.posterPath = posterPath
    self.isHighDefinition = isHighDefinition
  }

  var url: URL {
    let size = isHighDefinition ? "original" : "w500"
    let url = URL(string: "https://image.tmdb.org/t/p/\(size)")!
    return url.appending(path: posterPath)
  }

  var body: some View {
    AsyncImage(url: url) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
    } placeholder: {
      RoundedRectangle(cornerRadius: Constants.imageCornerRadius)
        .foregroundStyle(ColorToken.black20)
        .overlay {
          Image.Icon.popcorn
            .font(.system(size: Constants.popcornSize))
            .foregroundStyle(ColorToken.black60)
        }
    }
  }

  private enum Constants {
    static let imageCornerRadius = 8.0
    static let popcornSize = 52.0
  }
}

#Preview {
  BaseContentView {
    VStack {
      FilmImage(posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", isHighDefinition: false)
        .frame(width: 200, height: 300)
        .clipped()
      FilmImage(posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", isHighDefinition: true)
        .frame(width: 200, height: 300)
        .clipped()
    }
  }
}
