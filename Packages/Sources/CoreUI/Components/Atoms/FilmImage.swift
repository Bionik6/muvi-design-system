import SwiftUI

struct FilmImage: View {
  let posterPath: String

  var url: URL {
    let baseURLString = NSString(string: "https://image.tmdb.org/t/p/original")
    return URL(string: baseURLString.appendingPathComponent(posterPath))!
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
          Image(systemName: "popcorn.fill")
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
    FilmImage(posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg")
  }
}
