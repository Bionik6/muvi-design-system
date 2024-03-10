import CoreUI
import SwiftUI
import CoreModels
import YouTubePlayerKit

@MainActor
struct MoviesView: View {
  @State var path: [Film] = []
  private var model = MoviesModel()

  var body: some View {
    NavigationStack(path: $path) {
      BaseContentView {
        ScrollView {
          GeneralSection {
            FilmCarousel(
              films: model.topMovies.toCarouselFilmUIModel(onTap: { film in
                path.append(film)
              })
            )
          }

          GeneralSection(title: "Coming Soon", buttonTapAction: {}) {
            FilmsListView(
              displayMode: .horizontal,
              films: model.comingSoonMovies.toFilmListUIModel(onTap: { film in
                path.append(film)
              })
            )
          }

          GeneralSection(title: "Trending Now", buttonTapAction: {}) {
            FilmsListView(
              displayMode: .horizontal,
              films: model.trendingMovies.toFilmListUIModel(onTap: { film in
                path.append(film)
              })
            )
          }

          GeneralSection(title: "Latest Releases", buttonTapAction: {}) {
            FilmsListView(
              displayMode: .horizontal,
              films: model.latestMovies.toFilmListUIModel(onTap: { film in
                path.append(film)
              })
            )
          }

          GeneralSection(title: "Hits Box Office", buttonTapAction: {}) {
            FilmsListView(
              displayMode: .horizontal,
              films: model.popularMovies.toFilmListUIModel(onTap: { film in
                path.append(film)
              })
            )
          }
        }
      }
      .task { await model.fetchMovies() }
      .navigationTitle("Movies")
      .navigationDestination(for: Film.self) { film in
        FilmDetailsView(film: film)
      }
    }
  }
}

#Preview {
  NavigationStack {
    MoviesView()
      .loadCustomFonts()
  }
}
