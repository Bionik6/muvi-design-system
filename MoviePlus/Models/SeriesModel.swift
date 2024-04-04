import CoreModels
import Foundation
import Observation

@MainActor
@Observable
final class SeriesModel: FilmModel {
  var selectedFilm: Film?
  private let repository: SeriesRepository

  private(set) var isLoading = false
  private(set) var error: LocalizedError?
  private(set) var airingTodaySeries: [Film] = []
  private(set) var trendingSeries: [Film] = []
  private(set) var topRatedSeries: [Film] = []
  private(set) var popularSeries: [Film] = []

  init(repository: SeriesRepository = .live) {
    self.repository = repository
  }

  func fetchSeries() async {
    defer { isLoading = false }
    isLoading = true
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
