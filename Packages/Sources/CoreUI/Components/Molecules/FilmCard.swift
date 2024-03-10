import SwiftUI

struct FilmCard: View {
  private let title: String
  private let posterPath: String
  private let releaseYear: String
  private let voteCount: String
  private let voteAverage: String

  init(
    title: String,
    posterPath: String,
    releaseYear: String,
    voteCount: String,
    voteAverage: String
  ) {
    self.title = title
    self.posterPath = posterPath
    self.releaseYear = releaseYear
    self.voteCount = voteCount
    self.voteAverage = voteAverage
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      FilmImage(posterPath: posterPath)
        .frame(height: Constants.imageHeight)
        .frame(minWidth: Constants.imageWidth)
        .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
      VStack(alignment: .leading, spacing: 4) {
        FilmTitle(value: title)
        HStack {
          SummaryItem(title: releaseYear)
          Spacer()
          HStack(spacing: 10) {
            SummaryItem(title: voteCount, icon: Image.Icon.eye)
            SummaryItem(title: voteAverage, icon: Image.Icon.star)
          }
        }
        .foregroundStyle(ColorToken.black20)
      }
    }
    .foregroundColor(.white)
  }

  private enum Constants {
    static let imageWidth: CGFloat = 152
    static let imageHeight: CGFloat = 204
    static let imageCornerRadius: CGFloat = 8.0
  }
}

#Preview {
  BaseContentView {
    FilmCard(
      title: "Dune: Part Two",
      posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
      releaseYear: "2024",
      voteCount: "1532",
      voteAverage: "8.4"
    )
    .frame(width: 152, height: 252)
  }
  .loadCustomFonts()
}
