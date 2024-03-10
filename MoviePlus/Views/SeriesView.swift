import CoreUI
import SwiftUI

@MainActor
struct SeriesView: View {
  @State private var model = SeriesModel()

  var body: some View {
    NavigationStack {
      BaseContentView {
        ScrollView {
          GeneralSection(title: "Airing Today") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.airingTodaySeries.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.airingTodaySeries) }
            )
          }

          GeneralSection(title: "Trending Now") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.trendingSeries.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.trendingSeries) }
            )
          }

          GeneralSection(title: "Top Rated") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.topRatedSeries.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.topRatedSeries) }
            )
          }

          GeneralSection(title: "Hits Box Office") {
            FilmsListView(
              displayMode: .horizontal,
              films: model.popularSeries.toFilmListUIModel,
              onTap: { model.selectFilm(id: $0.id, in: model.popularSeries) }
            )
          }
        }
      }
      .task { await model.fetchSeries() }
      .navigationTitle("TV Shows")
      .navigationDestination(item: $model.selectedFilm) { film in
        FilmDetailsView(film: film)
      }
    }
  }
}

#Preview {
  NavigationStack {
    SeriesView()
      .loadCustomFonts()
  }
}
