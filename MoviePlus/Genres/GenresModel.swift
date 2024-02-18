import CoreModels
import Foundation
import Networking
import Observation

@Observable
final class GenresModel {
  private let movieId: Int
  private let repository: GenresRepository

  var error: LocalizedError?
  var movies: [MovieSerie] = []

  init(movieId: Int, repository: GenresRepository) {
    self.movieId = movieId
    self.repository = repository
  }

  @MainActor
  func fetchMovies() async {
    do {
      movies = try await repository.moviesByGenre(movieId).sanitize()
    } catch {
      self.error = error as? LocalizedError
    }
  }
}

struct GenresRepository: Sendable {
  static var client = APIClient()

  var moviesByGenre: @Sendable (Int) async throws -> [MovieSerie]

  static let live = Self { movieId in
    try await makeRequest(path: "genre/\(movieId)/movies")
  }

  private static func makeRequest(path: String) async throws -> [MovieSerie] {
    let request = Request(path: path)
    let response: MoviesResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
