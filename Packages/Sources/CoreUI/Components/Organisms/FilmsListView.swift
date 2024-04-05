import SwiftUI

public struct FilmsListView: View {
  private let displayMode: DisplayMode
  private let films: [UIModel]
  private let onTap: (UIModel) -> Void
  private let onBottomListReached: (() -> Void)?

  private let filmGrid = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

  public init(
    displayMode: DisplayMode,
    films: [UIModel],
    onTap: @escaping (UIModel) -> Void,
    onBottomListReached: (() -> Void)? = nil
  ) {
    self.displayMode = displayMode
    self.films = films
    self.onTap = onTap
    self.onBottomListReached = onBottomListReached
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
      HStack(spacing: Constants.horizontalSpacing) {
        filmsView
      }
    }
  }

  private var verticalView: some View {
    LazyVGrid(columns: filmGrid, spacing: Constants.verticalSpacing) {
      filmsView
    }
  }

  private var filmsView: some View {
    ForEach(films) { film in
      Button(action: { onTap(film) }) {
        FilmCard(
          title: film.title,
          posterPath: film.posterPath,
          releaseYear: film.releaseYear,
          voteCount: film.voteCount,
          voteAverage: film.voteAverage
        )
        .frame(maxWidth: displayMode == .horizontal ? Constants.imageWidth : .infinity)
        .onAppear {
          if film == films.last { onBottomListReached?() }
        }
      }
    }
  }

  private enum Constants {
    static let imageWidth: CGFloat = 152
    static let verticalSpacing: CGFloat = 24.0
    static let horizontalSpacing: CGFloat = 16.0
  }
}

extension FilmsListView {
  public enum DisplayMode {
    case horizontal
    case vertical
  }

  public struct UIModel: Equatable, Identifiable {
    public let id: Int
    public let posterPath: String
    public let title: String
    public let releaseYear: String
    public let voteCount: String
    public let voteAverage: String

    public init(
      id: Int,
      title: String,
      posterPath: String,
      releaseYear: String,
      voteCount: String,
      voteAverage: String
    ) {
      self.id = id
      self.posterPath = posterPath
      self.title = title
      self.releaseYear = releaseYear
      self.voteCount = voteCount
      self.voteAverage = voteAverage
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
            voteCount: "1.5K",
            voteAverage: "5.8"
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            voteCount: "1.3M",
            voteAverage: "8.4"
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            voteCount: "977K",
            voteAverage: "7.0"
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            voteCount: "873K",
            voteAverage: "6.6"
          ),
        ],
        onTap: { _ in },
        onBottomListReached: {}
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
            voteCount: "1.5K",
            voteAverage: "5.8"
          ),
          .init(
            id: 2,
            title: "Dune: Part Two",
            posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
            releaseYear: "2024",
            voteCount: "1.3M",
            voteAverage: "8.4"
          ),
          .init(
            id: 3,
            title: "Land of Bad",
            posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
            releaseYear: "2024",
            voteCount: "977K",
            voteAverage: "7.0"
          ),
          .init(
            id: 4,
            title: "Code 8 Part II",
            posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
            releaseYear: "2024",
            voteCount: "873K",
            voteAverage: "6.6"
          ),
        ],
        onTap: { _ in },
        onBottomListReached: {}
      )
      .padding()
    }
  }
  .loadCustomFonts()
}
