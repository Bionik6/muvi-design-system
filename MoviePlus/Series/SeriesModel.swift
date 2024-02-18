import CoreModels
import Foundation
import Networking
import Observation

@Observable
final class SeriesViewModel {
  private let repository: SeriesRepository

  var error: LocalizedError?
  var airingTodaySeries: [MovieSerie] = []
  var trendingSeries: [MovieSerie] = []
  var topRatedSeries: [MovieSerie] = []
  var popularSeries: [MovieSerie] = []

  init(repository: SeriesRepository = .live) {
    self.repository = repository
  }

  @MainActor
  func fetchSeries() async {
    async let airingTodaySeries = await repository.airingTodaySeries()
    async let trendingSeries = await repository.trendingSeries()
    async let topRatedSeries = await repository.topRatedSeries()
    async let popularSeries = await repository.popularSeries()
    do {
      let result = try await (
        airingTodaySeries: airingTodaySeries,
        trendingSeries: trendingSeries,
        topRatedSeries: topRatedSeries,
        popularSeries: popularSeries
      )
      self.airingTodaySeries = result.airingTodaySeries.sanitize()
      self.trendingSeries = result.trendingSeries.sanitize()
      self.topRatedSeries = result.topRatedSeries.sanitize()
      self.popularSeries = result.popularSeries.sanitize()
    } catch {
      self.error = error as? LocalizedError
    }
  }
}

struct SeriesRepository: Sendable {
  static var client = APIClient()

  var popularSeries: @Sendable () async throws -> [MovieSerie]
  var trendingSeries: @Sendable () async throws -> [MovieSerie]
  var topRatedSeries: @Sendable () async throws -> [MovieSerie]
  var airingTodaySeries: @Sendable () async throws -> [MovieSerie]

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

  private static func makeRequest(path: String) async throws -> [MovieSerie] {
    let request = Request(path: path)
    let response: MoviesResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .serie) }
  }
}
