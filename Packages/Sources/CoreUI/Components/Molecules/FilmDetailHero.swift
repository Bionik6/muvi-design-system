import SwiftUI

struct FilmDetailHero: View {
  private let title: String
  private let posterPath: String
  private let releaseYear: String
  private let viewsNumber: String
  private let vote: String
  private let genres: [String]
  private let onPlayTrailerButtonTapped: () -> Void

  init(
    title: String,
    posterPath: String,
    releaseYear: String,
    viewsNumber: String,
    vote: String,
    genres: [String],
    onPlayTrailerButtonTapped: @escaping () -> Void
  ) {
    self.title = title
    self.posterPath = posterPath
    self.releaseYear = releaseYear
    self.viewsNumber = viewsNumber
    self.vote = vote
    self.genres = genres
    self.onPlayTrailerButtonTapped = onPlayTrailerButtonTapped
  }

  var info: String {
    genres.joined(separator: ", ") + " · " + releaseYear
  }

  var body: some View {
    VStack {
      FilmImage(posterPath: posterPath)
        .frame(height: 500)
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
                SummaryItem(title: viewsNumber, icon: Image.Icon.eye)
                SummaryItem(title: vote, icon: Image.Icon.star)
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
            .padding(16)
          }
        }
      Spacer()
    }
  }
}

#Preview {
  BaseContentView {
    FilmDetailHero(
      title: "The Beekeeper",
      posterPath: "A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
      releaseYear: "2024",
      viewsNumber: "8.1m",
      vote: "9.0",
      genres: ["Action", "Adventure", "Fantasy"],
      onPlayTrailerButtonTapped: {}
    )
    .loadCustomFonts()
  }
}
