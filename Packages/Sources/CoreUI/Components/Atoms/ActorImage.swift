import SwiftUI

struct ActorImage: View {
  let posterPath: String

  var url: URL {
    let url = URL(string: "https://image.tmdb.org/t/p/original")!
    return url.appending(path: posterPath)
  }

  var body: some View {
    AsyncImage(url: url) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: Constants.imageSize, height: Constants.imageSize)
        .clipShape(Circle())
    } placeholder: {
      Circle()
        .frame(width: Constants.imageSize, height: Constants.imageSize)
        .foregroundStyle(ColorToken.black20)
        .overlay {
          Image.Icon.person
            .font(.system(size: Constants.popcornSize))
            .foregroundStyle(ColorToken.black60)
        }
    }
  }

  private enum Constants {
    static let popcornSize = 42.0
    static let imageSize = 100.0
  }
}

#Preview {
  BaseContentView {
    ActorImage(posterPath: "rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg")
  }
}
