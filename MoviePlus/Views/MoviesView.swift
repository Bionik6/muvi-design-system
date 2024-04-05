import CoreUI
import SwiftUI

@MainActor
struct MoviesView: View {
  @State private var model = MoviesModel()

  var body: some View {
    NavigationStack {
      BaseContentView {
        ScrollView {
          FilmCarousel(
            films: model.topMovies.toCarouselFilmUIModel,
            onTap: { model.selectFilm(id: $0.id, in: model.topMovies) }
          )
          .padding(.top, 16)

          GeneralSection(title: "Coming Soon") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.comingSoonMovies.toUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.comingSoonMovies) }
            )
          }

          GeneralSection(title: "Trending Now") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.trendingMovies.toUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.trendingMovies) }
            )
          }

          GeneralSection(title: "Latest Releases") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.latestMovies.toUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.latestMovies) }
            )
          }

          GeneralSection(title: "Hits Box Office") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.popularMovies.toUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.popularMovies) }
            )
          }
        }
      }
      .navigationTitle("Movies")
      .task { await model.fetchMovies() }
      .errorAlert(error: model.error, action: model.resetError)
      .refreshable(action: { await model.fetchMovies() })
      .loader(title: "Please wait while fetching movies", condition: model.isLoading)
      .navigationDestination(item: $model.selectedFilm) { film in
        FilmDetailsView(film: film)
      }
    }
  }
}

#Preview {
  MoviesView()
    .loadCustomFonts()
}
