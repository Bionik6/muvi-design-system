import CoreModels
import Foundation
import Networking
import Observation

@Observable
final class MoviesViewModel {
  private let repository: MoviesRepository

  var error: LocalizedError?
  var comingSoonMovies: [MovieSerie] = []
  var trendingMovies: [MovieSerie] = []
  var latestMovies: [MovieSerie] = []
  var popularMovies: [MovieSerie] = []

  init(repository: MoviesRepository = .live) {
    self.repository = repository
  }

  @MainActor
  func fetchMovies() async {
    async let comingSoonMovies = await repository.upcomingMovies()
    async let trendingMovies = await repository.trendingMovies()
    async let latestMovies = await repository.latestMovies()
    async let popularMovies = await repository.popularMovies()
    do {
      let result = try await (
        comingSoonMovies: comingSoonMovies,
        trendingMovies: trendingMovies,
        latestMovies: latestMovies,
        popularMovies: popularMovies
      )
      self.comingSoonMovies = result.comingSoonMovies.sanitize()
      self.trendingMovies = result.trendingMovies.sanitize()
      self.latestMovies = result.latestMovies.sanitize()
      self.popularMovies = result.popularMovies.sanitize()
    } catch {
      self.error = error as? LocalizedError
    }
  }
}

struct MoviesRepository: Sendable {
  static var client = APIClient()

  var upcomingMovies: @Sendable () async throws -> [MovieSerie]
  var trendingMovies: @Sendable () async throws -> [MovieSerie]
  var latestMovies: @Sendable () async throws -> [MovieSerie]
  var popularMovies: @Sendable () async throws -> [MovieSerie]

  static let live = Self(
    upcomingMovies: {
      try await makeRequest(path: "movie/upcoming")
    },
    trendingMovies: {
      try await makeRequest(path: "trending/all/week")
    },
    latestMovies: {
      try await makeRequest(path: "movie/now_playing")
    },
    popularMovies: {
      try await makeRequest(path: "movie/popular")
    }
  )

  private static func makeRequest(path: String) async throws -> [MovieSerie] {
    let request = Request(path: path)
    let response: MoviesResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
