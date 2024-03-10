import CoreUI
import SwiftUI
import CoreModels

@MainActor
@Observable
class FilmGenreModel {
  var selectedGenre: FilmGenre?

  func selectGenre(with id: Int) {
    guard let genre = filmGenres.first(where: { $0.id == id }) else {
      return
    }
    selectedGenre = genre
  }
}

@MainActor
struct FilmGenresView: View {
  @State private var model = FilmGenreModel()

  var body: some View {
    NavigationStack {
      BaseContentView {
        ScrollView {
          GeneralSection {
            FilmGenresListView(
              genres: filmGenres.toUIModel,
              onTap: { genre in model.selectGenre(with: genre.id) }
            )
          }
        }
      }
      .navigationDestination(item: $model.selectedGenre, destination: { genre in
        FilmsByGenreView(genre: genre)
      })
      .navigationTitle("Genres")
    }
  }
}

#Preview {
  FilmGenresView()
}
