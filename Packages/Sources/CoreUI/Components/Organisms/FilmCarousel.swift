import SwiftUI

public struct FilmCarousel: View {
  private let films: [UIModel]
  private let onTap: (UIModel) -> Void

  public init(
    films: [UIModel],
    onTap: @escaping (UIModel) -> Void
  ) {
    self.films = films
    self.onTap = onTap
  }

  public var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 0) {
        ForEach(films) { film in
          Button(action: { onTap(film) }) {
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
    .safeAreaPadding(.horizontal, 46)
  }
}

extension FilmCarousel {
  public struct UIModel: Identifiable {
    public let id: Int
    let posterPath: String
    let genres: [String]
    let releaseYear: String

    public init(
      id: Int,
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
}

#Preview {
  BaseContentView {
    FilmCarousel(
      films: [
        .init(
          id: 1,
          posterPath: "w0rYX6dDvcz1ASO4MAKPviaAj2x.jpg",
          genres: ["Fantasy", "Action", "Thriller"],
          releaseYear: "2024"
        ),
        .init(
          id: 2,
          posterPath: "h5bqIxM8GO4TewJ0u6Rzkg58ssJ.jpg",
          genres: ["Drama", "Romance", "Action"],
          releaseYear: "2024"
        ),
        .init(
          id: 3,
          posterPath: "74bCJPLuABIi0WWxtSaRYBtEKlc.jpg",
          genres: ["Drama", "Romance", "Action"],
          releaseYear: "2024"
        ),
        .init(
          id: 4,
          posterPath: "c8B4DsVcFVDLVmbpHMHU3RjLNAV.jpg",
          genres: ["Adventure", "Romance", "Comedy"],
          releaseYear: "2023"
        ),
        .init(
          id: 5,
          posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg",
          genres: ["Action", "Comedy", "Adventure"],
          releaseYear: "2025"
        ),
        .init(
          id: 6,
          posterPath: "zhV7B610l7hjlri4ywikJ18ONuq.jpg",
          genres: ["Fantasy", "Action", "Thriller"],
          releaseYear: "2024"
        ),
      ],
      onTap: { _ in }
    )
    .padding(.horizontal, 16)
  }

  .loadCustomFonts()
}
