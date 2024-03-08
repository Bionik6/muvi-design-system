import SwiftUI

struct FilmCard: View {
  private let posterPath: String
  private let title: String
  private let releaseYear: String
  private let viewsNumber: String
  private let vote: String

  init(
    posterPath: String,
    title: String,
    releaseYear: String,
    viewsNumber: String,
    vote: String
  ) {
    self.posterPath = posterPath
    self.title = title
    self.releaseYear = releaseYear
    self.viewsNumber = viewsNumber
    self.vote = vote
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      FilmImage(posterPath: posterPath)
        .frame(height: Constants.imageHeight)
        .frame(minWidth: Constants.imageWidth)
        .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
      FilmTitle(value: title)
      HStack {
        SummaryItem(title: releaseYear)
        Spacer()
        HStack(spacing: 10) {
          SummaryItem(title: viewsNumber, icon: Image.Icon.eye)
          SummaryItem(title: vote, icon: Image.Icon.star)
        }
      }
      .foregroundStyle(ColorToken.black20)
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
      posterPath: "xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
      title: "Dune: Part Two",
      releaseYear: "2024",
      viewsNumber: "1532",
      vote: "8.4"
    )
    .frame(width: 152, height: 252)
  }
  .loadCustomFonts()
}
