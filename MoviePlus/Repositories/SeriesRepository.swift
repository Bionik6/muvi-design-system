import Networking
import CoreModels
import Foundation

struct SeriesRepository: Sendable {
  let popularSeries: @Sendable () async throws -> [Film]
  let trendingSeries: @Sendable () async throws -> [Film]
  let topRatedSeries: @Sendable () async throws -> [Film]
  let airingTodaySeries: @Sendable () async throws -> [Film]

  static let live = Self(
    popularSeries: {
      try await makeRequest(path: "tv/airing_today")
    },
    trendingSeries: {
      try await makeRequest(path: "trending/tv/week")
    },
    topRatedSeries: {
      try await makeRequest(path: "tv/top_rated")
    },
    airingTodaySeries: {
      try await makeRequest(path: "tv/popular")
    }
  )

  private static func makeRequest(path: String) async throws -> [Film] {
    let client = URLSessionAPIClient()
    let request = Request(path: path)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .serie) }
  }
}
