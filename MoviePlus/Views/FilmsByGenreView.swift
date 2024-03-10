import CoreUI
import SwiftUI
import CoreModels

@MainActor
struct FilmsByGenreView: View {
  @State private var model: FilmsByGenreModel

  init(genre: FilmGenre) {
    self.model = FilmsByGenreModel(genre: genre)
  }

  var body: some View {
    BaseContentView {
      ScrollView {
        GeneralSection {
          FilmsListView(
            displayMode: .vertical,
            films: model.films.toFilmListUIModel,
            onTap: { model.selectFilm(id: $0.id, in: model.films) },
            onBottomListReached: { Task { await model.fetchFilms() } }
          )
        }
      }
    }
    .task { await model.fetchFilms() }
    .navigationTitle(model.genre.name)
    .navigationDestination(item: $model.selectedFilm) { film in
      FilmDetailsView(film: film)
    }
  }
}

#Preview {
  NavigationStack {
    FilmsByGenreView(genre: filmGenres[0])
  }
}
