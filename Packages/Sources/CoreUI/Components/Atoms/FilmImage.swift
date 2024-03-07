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
        .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
    } placeholder: {
      RoundedRectangle(cornerRadius: Constants.imageCornerRadius)
        .foregroundStyle(ColorToken.black20)
        .overlay {
          Image(systemName: "popcorn.fill")
            .font(.system(size: 52))
            .foregroundStyle(ColorToken.black60)
        }
    }
  }

  private enum Constants {
    static let imageCornerRadius = 8.0
  }
}

#Preview {
  BaseContentView {
    FilmImage(posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg")
  }
}
