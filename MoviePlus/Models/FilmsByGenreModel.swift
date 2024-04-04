import CoreModels
import Foundation
import Observation

@MainActor
@Observable
final class FilmsByGenreModel: FilmModel {
  var selectedFilm: Film?
  let genre: FilmGenre
  private let repository: GenresRepository

  private(set) var isLoading = false
  private(set) var error: LocalizedError?
  private(set) var films: [Film] = []
  private(set) var page: Int = 0

  init(genre: FilmGenre, repository: GenresRepository = .live) {
    self.genre = genre
    self.repository = repository
  }

  func fetchFilms() async {
    defer { isLoading = false }
    isLoading = true
    page += 1
    do {
      let fetchedFilms = try await repository.filmsByGenre(genre.id, page)
      films.append(contentsOf: fetchedFilms)
    } catch {
      self.error = error as? LocalizedError
    }
  }
}
