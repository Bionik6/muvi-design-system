import CoreModels
import Foundation
import Networking
import Observation

@Observable
class FilmDetailsModel {
  private let film: Film
  private let repository: FilmDetailsRepository

  private(set) var error: LocalizedError?
  private(set) var cast: [FilmActor] = []
  private(set) var clips: [FilmClip] = []
  private(set) var genres: [String] = []
  private(set) var trailerURLString: String?

  init(film: Film, repository: FilmDetailsRepository) {
    self.film = film
    self.repository = repository
  }

  @MainActor
  func fetchFilmDetails() async throws {
    async let filmDetails = await repository.details(film.id, film.type)
    async let cast = await repository.cast(film.id, film.type)
    async let clips = await repository.clips(film.id, film.type)
    do {
      let result = try await (filmDetails: filmDetails, cast: cast, clips: clips)
      genres = result.filmDetails.genres
      self.cast = result.cast.lazy
        .filter { $0.profileImagePath != nil }
        .sorted { $0.order < $1.order }
      self.clips = result.clips.lazy
        .filter { $0.site != nil && $0.site == .youtube }
      trailerURLString = self.clips
        .filter { $0.type != nil && $0.type == .trailer }
        .last?
        .key
    } catch {
      self.error = error as? LocalizedError
    }
  }
}

struct FilmDetailsRepository: Sendable {
  private static let client = APIClient()

  let details: @Sendable (Int, FilmType) async throws -> FilmDetails
  let cast: @Sendable (Int, FilmType) async throws -> [FilmActor]
  let clips: @Sendable (Int, FilmType) async throws -> [FilmClip]

  static let live = FilmDetailsRepository(
    details: { id, type in
      let request = Request(path: "\(type.rawValue)/\(id)")
      let response: RemoteFilmDetails = try await client.execute(request: request)
      return response.toModel(type: type)
    },
    cast: { id, type in
      let request = Request(path: "\(type.rawValue)/\(id)/credits")
      let response: CastResponse = try await client.execute(request: request)
      return response.cast.map(\.model)
    },
    clips: { id, type in
      let request = Request(path: "\(type.rawValue)/\(id)/videos")
      let response: ClipResponse = try await client.execute(request: request)
      return response.results.map(\.model)
    }
  )
}
