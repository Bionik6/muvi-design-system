import CoreModels
import Foundation
import Networking
import Observation

@Observable
final class MoviesViewModel {
  private let repository: MoviesRepository

  private(set) var error: LocalizedError?
  private(set) var comingSoonMovies: [Film] = []
  private(set) var trendingMovies: [Film] = []
  private(set) var latestMovies: [Film] = []
  private(set) var popularMovies: [Film] = []

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
  private static let client = APIClient()

  let upcomingMovies: @Sendable () async throws -> [Film]
  let trendingMovies: @Sendable () async throws -> [Film]
  let latestMovies: @Sendable () async throws -> [Film]
  let popularMovies: @Sendable () async throws -> [Film]

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

  private static func makeRequest(path: String) async throws -> [Film] {
    let request = Request(path: path)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
