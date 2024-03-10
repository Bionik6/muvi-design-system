import CoreModels
import Observation

@MainActor
@Observable
class FilmGenresModel {
  var selectedGenre: FilmGenre?

  func selectGenre(with id: Int) {
    guard let genre = filmGenres.first(where: { $0.id == id }) else {
      return
    }
    selectedGenre = genre
  }
}
