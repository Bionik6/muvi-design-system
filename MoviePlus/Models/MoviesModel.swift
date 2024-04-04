import CoreModels
import Foundation
import Observation

@MainActor
@Observable
final class MoviesModel: FilmModel {
  var selectedFilm: Film?
  private let repository: MoviesRepository

  private(set) var isLoading = false

  private(set) var error: LocalizedError?
  private(set) var topMovies: [Film] = []
  private(set) var comingSoonMovies: [Film] = []
  private(set) var trendingMovies: [Film] = []
  private(set) var latestMovies: [Film] = []
  private(set) var popularMovies: [Film] = []

  init(repository: MoviesRepository = .live) {
    self.repository = repository
  }

  func fetchMovies() async {
    defer { isLoading = false }
    isLoading = true
    async let topMovies = await repository.topMovies()
    async let comingSoonMovies = await repository.upcomingMovies()
    async let trendingMovies = await repository.trendingMovies()
    async let latestMovies = await repository.latestMovies()
    async let popularMovies = await repository.popularMovies()
    do {
      let result = try await (
        topMovies: topMovies,
        comingSoonMovies: comingSoonMovies,
        trendingMovies: trendingMovies,
        latestMovies: latestMovies,
        popularMovies: popularMovies
      )
      self.topMovies = result.topMovies.sanitize()
      self.comingSoonMovies = result.comingSoonMovies.sanitize()
      self.trendingMovies = result.trendingMovies.sanitize()
      self.latestMovies = result.latestMovies.sanitize()
      self.popularMovies = result.popularMovies.sanitize()
    } catch {
      self.error = error as? LocalizedError
    }
  }
}
