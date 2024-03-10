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
            FilmHeroCard(posterPath: film.posterPath)
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

    public init(
      id: Int,
      posterPath: String
    ) {
      self.id = id
      self.posterPath = posterPath
    }
  }
}

#Preview {
  BaseContentView {
    FilmCarousel(
      films: [
        .init(
          id: 1,
          posterPath: "w0rYX6dDvcz1ASO4MAKPviaAj2x.jpg"
        ),
        .init(
          id: 2,
          posterPath: "h5bqIxM8GO4TewJ0u6Rzkg58ssJ.jpg"
        ),
        .init(
          id: 3,
          posterPath: "74bCJPLuABIi0WWxtSaRYBtEKlc.jpg"
        ),
        .init(
          id: 4,
          posterPath: "c8B4DsVcFVDLVmbpHMHU3RjLNAV.jpg"
        ),
        .init(
          id: 5,
          posterPath: "gavGnAMTXPkpoFgG0stwgIgKb64.jpg"
        ),
        .init(
          id: 6,
          posterPath: "zhV7B610l7hjlri4ywikJ18ONuq.jpg"
        ),
      ],
      onTap: { _ in }
    )
  }
  .loadCustomFonts()
}
