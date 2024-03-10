import SwiftUI

public struct FilmCarousel: View {
  private let films: [FilmUIModel]

  public init(films: [FilmUIModel]) {
    self.films = films
  }

  public var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 0) {
        ForEach(films) { film in
          Button(action: film.onTap) {
            FilmHeroCard(
              posterPath: film.posterPath,
              releaseYear: film.releaseYear,
              genres: film.genres
            )
            .foregroundStyle(ColorToken.white)
          }
          .scrollTransition { content, phase in
            content.scaleEffect(phase.isIdentity ? 1 : 0.9)
          }
        }
      }
      .scrollTargetLayout()
    }
    .scrollTargetBehavior(.viewAligned)
    .safeAreaPadding(.horizontal, 30)
  }
}

extension FilmCarousel {
  public struct FilmUIModel: Identifiable, Equatable {
    public let id: Int
    let posterPath: String
    let genres: [String]
    let releaseYear: String
    let onTap: () -> Void

    public init(
      id: Int,
      posterPath: String,
      genres: [String],
      releaseYear: String,
      onTap: @escaping () -> Void
    ) {
      self.id = id
      self.posterPath = posterPath
      self.genres = genres
      self.releaseYear = releaseYear
      self.onTap = onTap
    }

    public static func ==(
      lhs: FilmCarousel.FilmUIModel,
      rhs: FilmCarousel.FilmUIModel
    ) -> Bool {
      lhs.id == rhs.id
    }
  }
}

#Preview {
  BaseContentView {
    FilmCarousel(
      films: [
        .init(
          id: 1,
          posterPath: "w0rYX6dDvcz1ASO4MAKPviaAj2x.jpg",
          genres: ["Fantasy", "Action", "Thriller"],
          releaseYear: "2024",
          onTap: {}
        ),
        .init(
          id: 2,
          posterPath: "h5bqIxM8GO4TewJ0u6Rzkg58ssJ.jpg",
          genres: ["Drama", "Romance", "Action"],
          releaseYear: "2024",
          onTap: {}
        ),
        .init(
          id: 3,
          posterPath: "74bCJPLuABIi0WWxtSaRYBtEKlc.jpg",
          genres: ["Drama", "Romance", "Action"],
          releaseYear: "2024",
          onTap: {}
        ),
        .init(
          id: 4,
          posterPath: "c8B4DsVcFVDLVmbpHMHU3RjLNAV.jpg",
          genres: ["Adventure", "Romance", "Comedy"],
          releaseYear: "2023",
          onTap: {}
        ),
        .init(
          id: 5,
          posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg",
          genres: ["Action", "Comedy", "Adventure"],
          releaseYear: "2025",
          onTap: {}
        ),
        .init(
          id: 6,
          posterPath: "zhV7B610l7hjlri4ywikJ18ONuq.jpg",
          genres: ["Fantasy", "Action", "Thriller"],
          releaseYear: "2024",
          onTap: {}
        ),
      ]
    )
    .padding(.horizontal, 16)
  }

  .loadCustomFonts()
}
