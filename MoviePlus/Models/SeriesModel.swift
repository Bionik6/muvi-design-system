import CoreModels
import Foundation
import Networking
import Observation

@MainActor
@Observable
final class SeriesModel: FilmModel {
  var selectedFilm: Film?
  private let repository: SeriesRepository

  private(set) var error: LocalizedError?
  private(set) var airingTodaySeries: [Film] = []
  private(set) var trendingSeries: [Film] = []
  private(set) var topRatedSeries: [Film] = []
  private(set) var popularSeries: [Film] = []

  init(repository: SeriesRepository = .live) {
    self.repository = repository
  }

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
  private static let client = APIClient()

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
    let request = Request(path: path)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .serie) }
  }
}
