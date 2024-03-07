import SwiftUI

public struct FilmCarousel: View {
  private let pages: [Page]

  public init(pages: [Page]) {
    self.pages = pages
  }

  public var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack {
        ForEach(pages) { page in
          FilmHeroCard(
            posterPath: page.film.posterPath,
            releaseYear: page.film.releaseYear,
            genres: page.film.genres,
            onButtonTap: page.onButtonTap
          )
          .scrollTransition { content, phase in
            content.scaleEffect(phase.isIdentity ? 1 : 0.9)
          }
        }
      }
      .scrollTargetLayout()
    }
    .scrollTargetBehavior(.viewAligned)
    .safeAreaPadding(.horizontal, 44)
  }
}

extension FilmCarousel {
  public struct FilmUIModel: Identifiable, Equatable {
    public let id: UUID
    let posterPath: String
    let genres: [String]
    let releaseYear: String

    public init(
      id: UUID,
      posterPath: String,
      genres: [String],
      releaseYear: String
    ) {
      self.id = id
      self.posterPath = posterPath
      self.genres = genres
      self.releaseYear = releaseYear
    }
  }

  public struct Page: Identifiable, Equatable {
    let film: FilmUIModel
    public let id: UUID
    let onButtonTap: () -> Void

    init(
      id: UUID = .init(),
      film: FilmUIModel,
      onButtonTap: @escaping () -> Void
    ) {
      self.id = id
      self.film = film
      self.onButtonTap = onButtonTap
    }

    public static func ==(lhs: FilmCarousel.Page, rhs: FilmCarousel.Page) -> Bool {
      lhs.id == rhs.id
    }
  }
}

#Preview {
  BaseContentView {
    FilmCarousel(
      pages: [
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "w0rYX6dDvcz1ASO4MAKPviaAj2x.jpg",
            genres: ["Fantasy", "Action", "Thriller"],
            releaseYear: "2024"
          ),
          onButtonTap: {}
        ),
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "h5bqIxM8GO4TewJ0u6Rzkg58ssJ.jpg",
            genres: ["Drama", "Romance", "Action"],
            releaseYear: "2024"
          ),
          onButtonTap: {}
        ),
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "74bCJPLuABIi0WWxtSaRYBtEKlc.jpg",
            genres: ["Drama", "Romance", "Action"],
            releaseYear: "2024"
          ),
          onButtonTap: {}
        ),
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "c8B4DsVcFVDLVmbpHMHU3RjLNAV.jpg",
            genres: ["Adventure", "Romance", "Comedy"],
            releaseYear: "2023"
          ),
          onButtonTap: {}
        ),
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg",
            genres: ["Action", "Comedy", "Adventure"],
            releaseYear: "2025"
          ),
          onButtonTap: {}
        ),
        .init(
          id: UUID(),
          film: .init(
            id: UUID(),
            posterPath: "zhV7B610l7hjlri4ywikJ18ONuq.jpg",
            genres: ["Fantasy", "Action", "Thriller"],
            releaseYear: "2024"
          ),
          onButtonTap: {}
        ),
      ]
    )
  }
  .loadCustomFonts()
}
