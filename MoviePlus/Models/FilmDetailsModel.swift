import CoreModels
import Foundation
import Observation

@MainActor
@Observable
class FilmDetailsModel {
  let film: Film
  var selectedClip: FilmClip?
  var playTrailer: Bool = false
  private let repository: FilmDetailsRepository

  private(set) var isLoading = false
  private(set) var error: LocalizedError?
  private(set) var cast: [FilmActor] = []
  private(set) var clips: [FilmClip] = []
  private(set) var genres: [String] = []
  private(set) var filmTrailerKey: String?

  init(film: Film, repository: FilmDetailsRepository = .live) {
    self.film = film
    self.repository = repository
  }

  func fetchFilmDetails() async {
    defer { isLoading = false }
    isLoading = true
    async let details = await repository.details(film.id, film.type)
    async let cast = await repository.cast(film.id, film.type)
    async let clips = await repository.clips(film.id, film.type)
    do {
      let result = try await (filmDetails: details, cast: cast, clips: clips)
      genres = result.filmDetails.genres ?? []
      self.cast = result.cast.lazy
        .filter { $0.profileImagePath != nil }
        .sorted { $0.order < $1.order }
      self.clips = result.clips.lazy
        .filter { $0.site != nil && $0.site == .youtube }
      filmTrailerKey = self.clips
        .filter { $0.type != nil && $0.type == .trailer }
        .last?
        .key
    } catch {
      self.error = error as? LocalizedError
    }
  }

  func playFilmClip(for key: String) {
    selectedClip = clips.first(where: { $0.key == key })
  }

  func playFilmTrailer() {
    playTrailer = true
  }
}
