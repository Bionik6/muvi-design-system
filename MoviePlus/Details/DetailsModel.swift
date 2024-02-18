import CoreModels
import Foundation
import Networking
import Observation

@Observable
class MediaDetailsViewModel {
  private let media: MovieSerie
  private let repository: DetailsRepository

  var error: LocalizedError?
  var cast: [MovieActor] = []
  var clips: [MovieClip] = []
  var genres: [String] = []
  var trailerURLString: String?

  init(
    media: MovieSerie,
    repository: DetailsRepository = .live
  ) {
    self.media = media
    self.repository = repository
  }

  @MainActor
  func fetchAllMediaDetails() async throws {
    async let mediaDetails = await repository.details(media.id, media.type)
    async let cast = await repository.cast(media.id, media.type)
    async let clips = await repository.clips(media.id, media.type)
    do {
      let result = try await (mediaDetails: mediaDetails, cast: cast, clips: clips)
      genres = result.mediaDetails.genres
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

struct DetailsRepository: Sendable {
  static var client = APIClient()

  var details: @Sendable (Int, MediaType) async throws -> MediaDetails
  var cast: @Sendable (Int, MediaType) async throws -> [MovieActor]
  var clips: @Sendable (Int, MediaType) async throws -> [MovieClip]

  static let live = DetailsRepository(
    details: { id, type in
      let request = Request(path: "\(type.rawValue)/\(id)")
      let response: RemoteMovieSerieDetails = try await client.execute(request: request)
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
