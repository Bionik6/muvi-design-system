import CoreModels
import Foundation
import Networking
import Observation

@MainActor
@Observable
final class FilmsByGenreModel: FilmModel {
  var selectedFilm: Film?
  let genre: FilmGenre
  private let repository: GenresRepository

  private(set) var error: LocalizedError?
  private(set) var films: [Film] = []
  private(set) var page: Int = 0

  init(genre: FilmGenre, repository: GenresRepository = .live) {
    self.genre = genre
    self.repository = repository
  }

  func fetchFilms() async {
    page += 1
    do {
      let fetchedFilms = try await repository.filmsByGenre(genre.id, page)
      films.append(contentsOf: fetchedFilms)
    } catch {
      self.error = error as? LocalizedError
    }
  }
}

struct GenresRepository: Sendable {
  private static let client = APIClient()

  let filmsByGenre: @Sendable (Int, Int) async throws -> [Film]

  static let live = Self { genreId, page in
    let params = RequestParams.url(["page": page])
    let path = "genre/\(genreId)/movies"
    let request = Request(path: path, params: params)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
