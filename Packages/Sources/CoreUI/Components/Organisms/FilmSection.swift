import SwiftUI

public struct FilmSection: View {
  private let title: LocalizedStringResource
  private let displayMode: DisplayMode
  private let films: [FilmUIModel]
  private let onRightButtonTapped: (() -> Void)?

  private let filmGrid = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

  public init(
    title: LocalizedStringResource,
    displayMode: DisplayMode,
    films: [FilmUIModel],
    onRightButtonTapped: (() -> Void)?
  ) {
    self.title = title
    self.displayMode = displayMode
    self.films = films
    self.onRightButtonTapped = onRightButtonTapped
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      FilmHeader(
        title: title,
        onRightButtonTapped: onRightButtonTapped
      )
      switch displayMode {
      case .horizontally:
        horizontalView
      case .vertically:
        verticalView
      }
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
      Button(action: { film.onTap(film.id) }) {
        FilmCard(
          posterPath: film.posterPath,
          title: film.title,
          releaseYear: film.releaseYear,
          viewsNumber: film.viewsNumber,
          vote: film.vote
        )
      }
    }
  }
}

extension FilmSection {
  public enum DisplayMode {
    case horizontally
    case vertically
  }

  public struct FilmUIModel: Identifiable, Equatable {
    public let id: Int
    let posterPath: String
    let title: String
    let releaseYear: String
    let viewsNumber: String
    let vote: String
    let onTap: (Int) -> Void

    public init(
      id: Int,
      title: String,
      posterPath: String,
      releaseYear: String,
      viewsNumber: String,
      vote: String,
      onTap: @escaping (Int) -> Void
    ) {
      self.id = id
      self.posterPath = posterPath
      self.title = title
      self.releaseYear = releaseYear
      self.viewsNumber = viewsNumber
      self.vote = vote
      self.onTap = onTap
    }

    public static func ==(lhs: FilmSection.FilmUIModel, rhs: FilmSection.FilmUIModel) -> Bool {
      lhs.id == rhs.id
    }
  }
}

#Preview {
  BaseContentView {
    ScrollView {
      FilmSection(
        title: "Trending Now",
        displayMode: .horizontally,
        films: [
          .init(
            id: 1,
            title: "No Way Up",
            posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
            releaseYear: "2024",
            viewsNumber: "1.5K",
            vote: "5.8",
            onTap: { _ in }
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            viewsNumber: "1.3M",
            vote: "8.4",
            onTap: { _ in }
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            viewsNumber: "977K",
            vote: "7.0",
            onTap: { _ in }
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            viewsNumber: "873K",
            vote: "6.6",
            onTap: { _ in }
          ),
        ],
        onRightButtonTapped: {}
      )
      .padding()

      FilmSection(
        title: "Trending Now",
        displayMode: .vertically,
        films: [
          .init(
            id: 1,
            title: "No Way Up",
            posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
            releaseYear: "2024",
            viewsNumber: "1.5K",
            vote: "5.8",
            onTap: { _ in }
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            viewsNumber: "1.3M",
            vote: "8.4",
            onTap: { _ in }
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            viewsNumber: "977K",
            vote: "7.0",
            onTap: { _ in }
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            viewsNumber: "873K",
            vote: "6.6",
            onTap: { _ in }
          ),
        ],
        onRightButtonTapped: nil
      )
      .padding()
    }
  }
  .loadCustomFonts()
}
