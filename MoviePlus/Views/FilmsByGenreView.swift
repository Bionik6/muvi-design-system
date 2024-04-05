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
            films: model.films.toUIModel,
            onTap: { model.selectFilm(id: $0.id, in: model.films) },
            onBottomListReached: { Task { await model.fetchFilms() } }
          )
        }
      }
    }
    .navigationTitle(model.genre.name)
    .task { await model.fetchFilms() }
    .refreshable(action: { await model.fetchFilms() })
    .errorAlert(error: model.error, action: model.resetError)
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
