import Networking
import CoreModels
import Foundation

struct MoviesRepository: Sendable {
  let topMovies: @Sendable () async throws -> [Film]
  let upcomingMovies: @Sendable () async throws -> [Film]
  let trendingMovies: @Sendable () async throws -> [Film]
  let latestMovies: @Sendable () async throws -> [Film]
  let popularMovies: @Sendable () async throws -> [Film]

  static let live = Self(
    topMovies: {
      try await makeRequest(path: "discover/movie")
    },
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
    let client = URLSessionAPIClient()
    let request = Request(path: path)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
