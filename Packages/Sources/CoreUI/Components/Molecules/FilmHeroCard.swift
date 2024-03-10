import SwiftUI

struct FilmHeroCard: View {
  private let posterPath: String

  init(
    posterPath: String
  ) {
    self.posterPath = posterPath
  }

  var body: some View {
    FilmImage(posterPath: posterPath, isHighDefinition: false)
      .frame(width: Constants.imageWidth, height: Constants.imageHeight)
      .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
  }

  private enum Constants {
    static let imageWidth: CGFloat = 303
    static let imageHeight: CGFloat = 404
    static let imageCornerRadius: CGFloat = 24.0
  }
}

#Preview {
  BaseContentView {
    FilmHeroCard(posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg")
      .loadCustomFonts()
  }
}
