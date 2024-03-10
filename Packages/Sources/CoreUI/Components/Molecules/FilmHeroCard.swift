import SwiftUI

struct FilmHeroCard: View {
  private let posterPath: String
  private let releaseYear: String
  private let genres: [String]

  init(
    posterPath: String,
    releaseYear: String,
    genres: [String]
  ) {
    self.posterPath = posterPath
    self.releaseYear = releaseYear
    self.genres = genres
  }

  var body: some View {
    FilmImage(posterPath: posterPath)
      .frame(width: Constants.imageWidth, height: Constants.imageHeight)
      .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
      .overlay(alignment: .bottom) {
        ZStack(alignment: .bottom) {
          LinearGradient(
            colors: [
              Color.black.opacity(0),
              Color.black.opacity(0.9),
            ],
            startPoint: .top,
            endPoint: .bottom
          )
          .frame(height: Constants.linearBackgroundHeight)
          .clipShape(
            UnevenRoundedRectangle(
              cornerRadii: RectangleCornerRadii(
                bottomLeading: Constants.imageCornerRadius,
                bottomTrailing: Constants.imageCornerRadius
              ),
              style: .continuous
            )
          )
          Text(info)
            .font(CustomFont.caption1)
            .multilineTextAlignment(.center)
            .padding(.bottom, Constants.genresBottomPadding)
        }
      }
  }

  var info: String {
    genres.joined(separator: ", ") + " · " + releaseYear
  }

  private enum Constants {
    static let imageWidth: CGFloat = 303
    static let imageHeight: CGFloat = 404
    static let imageCornerRadius: CGFloat = 24.0
    static let genresBottomPadding: CGFloat = 20
    static let linearBackgroundHeight: CGFloat = 90
  }
}

#Preview {
  BaseContentView {
    VStack {
      FilmHeroCard(
        posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg",
        releaseYear: "2024",
        genres: ["Action", "Fantasy", "Trailer"]
      )
    }
    .loadCustomFonts()
  }
}