import CoreModels
import Networking
import Observation

struct GenresRepository {
  public static var client = APIClient()

  var moviesByGenre: (Int) async throws -> [MovieSerie]

  static let live = Self { movieId in
    try await makeRequest(path: "genre/\(movieId)/movies")
  }

  private static func makeRequest(path: String) async throws -> [MovieSerie] {
    let request = Request(path: path)
    let response: MoviesResponse = try await client.execute(request: request)
    return response.results.map(\.model)
  }
}

@Observable
final class GenresModel {
  private let movieId: Int
  private let repository: GenresRepository

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
      print(error.localizedDescription)
    }
  }
}
