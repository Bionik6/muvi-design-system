import SwiftUI

public struct FilmDetailHero: View {
  private let title: String
  private let posterPath: String
  private let releaseYear: String
  private let voteCount: String
  private let voteAgerage: String
  private let genres: [String]
  private let onPlayTrailerButtonTapped: () -> Void

  public init(
    title: String,
    posterPath: String,
    releaseYear: String,
    voteCount: String,
    voteAverage: String,
    genres: [String],
    onPlayTrailerButtonTapped: @escaping () -> Void
  ) {
    self.title = title
    self.posterPath = posterPath
    self.releaseYear = releaseYear
    self.voteCount = voteCount
    self.voteAgerage = voteAverage
    self.genres = genres
    self.onPlayTrailerButtonTapped = onPlayTrailerButtonTapped
  }

  var info: String {
    genres.joined(separator: ", ") + " · " + releaseYear
  }

  public var body: some View {
    VStack {
      FilmImage(posterPath: posterPath, isHighDefinition: true)
        .frame(height: Constants.imageHeight)
        .clipShape(Rectangle())
        .overlay(alignment: .bottom) {
          ZStack(alignment: .bottom) {
            LinearGradient(
              colors: [
                Color.black.opacity(0.9),
                Color.black.opacity(0),
              ],
              startPoint: UnitPoint(x: 0.5, y: 1),
              endPoint: UnitPoint(x: 0.5, y: 0.4)
            )

            VStack(alignment: .leading, spacing: 12) {
              Text(title)
                .font(CustomFont.heading2)
              Text(info)
                .font(CustomFont.body2)
                .multilineTextAlignment(.leading)
              HStack(spacing: 16) {
                SummaryItem(title: voteCount, icon: Image.Icon.eye)
                SummaryItem(title: voteAgerage, icon: Image.Icon.star)
              }
              HStack {
                OutilneButton(
                  title: "Watchlist",
                  action: {}
                )
                PlayFilmButton(
                  title: "Play trailer",
                  displayMode: .flexible,
                  action: onPlayTrailerButtonTapped
                )
              }
            }
            .padding(Constants.padding)
          }
        }
      Spacer()
    }
  }

  private enum Constants {
    static let imageHeight: CGFloat = 500
    static let padding: CGFloat = 16.0
  }
}

#Preview {
  BaseContentView {
    FilmDetailHero(
      title: "The Beekeeper",
      posterPath: "A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
      releaseYear: "2024",
      voteCount: "8.2m",
      voteAverage: "9.8",
      genres: ["Action", "Adventure", "Fantasy"],
      onPlayTrailerButtonTapped: {}
    )
    .loadCustomFonts()
  }
}
