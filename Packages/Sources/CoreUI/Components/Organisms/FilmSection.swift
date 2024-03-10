import SwiftUI

public struct FilmsListView: View {
  private let displayMode: DisplayMode
  private let films: [FilmUIModel]
  private let onTap: (FilmUIModel) -> Void

  private let filmGrid = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

  public init(
    displayMode: DisplayMode,
    films: [FilmUIModel],
    onTap: @escaping (FilmUIModel) -> Void
  ) {
    self.displayMode = displayMode
    self.films = films
    self.onTap = onTap
  }

  public var body: some View {
    switch displayMode {
    case .horizontal:
      horizontalView
    case .vertical:
      verticalView
    }
  }

  private var horizontalView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        filmsView
      }
    }
  }

  private var verticalView: some View {
    LazyVGrid(columns: filmGrid, spacing: 24) {
      filmsView
    }
  }

  private var filmsView: some View {
    ForEach(films) { film in
      Button(action: { onTap(film) }) {
        FilmCard(
          posterPath: film.posterPath,
          title: film.title,
          releaseYear: film.releaseYear,
          viewsNumber: film.viewsNumber,
          vote: film.vote
        )
        .frame(maxWidth: displayMode == .horizontal ? 152 : .infinity)
      }
    }
  }
}

extension FilmsListView {
  public enum DisplayMode {
    case horizontal
    case vertical
  }

  public struct FilmUIModel: Identifiable {
    public let id: Int
    let posterPath: String
    let title: String
    let releaseYear: String
    let viewsNumber: String
    let vote: String

    public init(
      id: Int,
      title: String,
      posterPath: String,
      releaseYear: String,
      viewsNumber: String,
      vote: String
    ) {
      self.id = id
      self.posterPath = posterPath
      self.title = title
      self.releaseYear = releaseYear
      self.viewsNumber = viewsNumber
      self.vote = vote
    }
  }
}

#Preview {
  BaseContentView {
    ScrollView {
      FilmsListView(
        displayMode: .horizontal,
        films: [
          .init(
            id: 1,
            title: "No Way Up",
            posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
            releaseYear: "2024",
            viewsNumber: "1.5K",
            vote: "5.8"
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            viewsNumber: "1.3M",
            vote: "8.4"
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            viewsNumber: "977K",
            vote: "7.0"
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            viewsNumber: "873K",
            vote: "6.6"
          ),
        ],
        onTap: { _ in }
      )
      .padding()

      FilmsListView(
        displayMode: .vertical,
        films: [
          .init(
            id: 1,
            title: "No Way Up",
            posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
            releaseYear: "2024",
            viewsNumber: "1.5K",
            vote: "5.8"
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            viewsNumber: "1.3M",
            vote: "8.4"
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            viewsNumber: "977K",
            vote: "7.0"
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            viewsNumber: "873K",
            vote: "6.6"
          ),
        ],
        onTap: { _ in }
      )
      .padding()
    }
  }
  .loadCustomFonts()
}
