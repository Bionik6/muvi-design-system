import CoreUI
import SwiftUI

@MainActor
struct MoviesView: View {
  @State private var model = MoviesModel()

  var body: some View {
    NavigationStack {
      BaseContentView {
        ScrollView {
          GeneralSection {
            FilmCarousel(
              films: model.topMovies.toCarouselFilmUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.topMovies) }
            )
          }

          GeneralSection(title: "Coming Soon") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.comingSoonMovies.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.comingSoonMovies) }
            )
          }

          GeneralSection(title: "Trending Now") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.trendingMovies.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.trendingMovies) }
            )
          }

          GeneralSection(title: "Latest Releases") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.latestMovies.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.latestMovies) }
            )
          }

          GeneralSection(title: "Hits Box Office") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.popularMovies.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.popularMovies) }
            )
          }
        }
      }
      .task { await model.fetchMovies() }
      .navigationTitle("Movies")
      .navigationDestination(item: $model.selectedFilm) { film in
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
