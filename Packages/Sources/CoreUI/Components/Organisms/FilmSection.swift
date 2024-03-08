import SwiftUI

public struct FilmSection: View {
  private let title: LocalizedStringResource
  private let displayMode: DisplayMode
  private let items: [FilmItem]
  private let onRightButtonTapped: (() -> Void)?
  
  private let filmGrid = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
  
  public init(
    title: LocalizedStringResource,
    displayMode: DisplayMode,
    items: [FilmItem],
    onRightButtonTapped: (() -> Void)?
  ) {
    self.title = title
    self.displayMode = displayMode
    self.items = items
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
    ForEach(items) { item in
      Button(action: item.onFilmTap) {
        FilmCard(
          posterPath: item.film.posterPath,
          title: item.film.title,
          releaseYear: item.film.releaseYear,
          viewsNumber: item.film.viewsNumber,
          vote: item.film.vote
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
    public let id: UUID
    let posterPath: String
    let title: String
    let releaseYear: String
    let viewsNumber: String
    let vote: String

    public init(
      id: UUID,
      title: String,
      posterPath: String,
      releaseYear: String,
      viewsNumber: String,
      vote: String
    ) {
      self.id = id
      self.title = title
      self.posterPath = posterPath
      self.releaseYear = releaseYear
      self.viewsNumber = viewsNumber
      self.vote = vote
    }
  }

  public struct FilmItem: Identifiable, Equatable {
    public let id: UUID
    let film: FilmUIModel
    let onFilmTap: () -> ()

    init(
      id: UUID,
      film: FilmUIModel,
      onFilmTap: @escaping () -> Void
    ) {
      self.id = id
      self.film = film
      self.onFilmTap = onFilmTap
    }
    
    public static func == (lhs: FilmSection.FilmItem, rhs: FilmSection.FilmItem) -> Bool {
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
        items: [
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "No Way Up",
              posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
              releaseYear: "2024",
              viewsNumber: "1.5K",
              vote: "5.8"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Dune: Part Two",
              posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
              releaseYear: "2024",
              viewsNumber: "1.3M",
              vote: "8.4"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Land of Bad",
              posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
              releaseYear: "2024",
              viewsNumber: "977K",
              vote: "7.0"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Code 8 Part II",
              posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
              releaseYear: "2024",
              viewsNumber: "873K",
              vote: "6.6"
            ),
            onFilmTap: {}
          )
        ],
        onRightButtonTapped: { }
      )
      .padding()
      
      FilmSection(
        title: "Trending Now",
        displayMode: .vertically,
        items: [
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "No Way Up",
              posterPath: "hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg",
              releaseYear: "2024",
              viewsNumber: "1.5K",
              vote: "5.8"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Dune: Part Two",
              posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
              releaseYear: "2024",
              viewsNumber: "1.3M",
              vote: "8.4"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Land of Bad",
              posterPath: "h27WHO2czaY5twDmV3Wfx5IdqoE.jpg",
              releaseYear: "2024",
              viewsNumber: "977K",
              vote: "7.0"
            ),
            onFilmTap: {}
          ),
          .init(
            id: UUID(),
            film: .init(
              id: UUID(),
              title: "Code 8 Part II",
              posterPath: "hhvMTxlTZtnCOe7YFhod9uz3m37.jpg",
              releaseYear: "2024",
              viewsNumber: "873K",
              vote: "6.6"
            ),
            onFilmTap: {}
          )
        ],
        onRightButtonTapped: nil
      )
      .padding()
    }
  }
  .loadCustomFonts()
}
