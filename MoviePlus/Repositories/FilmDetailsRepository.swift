import Foundation
import CoreModels
import Networking

struct FilmDetailsRepository: Sendable {
  let details: @Sendable (Int, FilmType) async throws -> Film
  let cast: @Sendable (Int, FilmType) async throws -> [FilmActor]
  let clips: @Sendable (Int, FilmType) async throws -> [FilmClip]

  static let live = FilmDetailsRepository(
    details: { id, type in
      let response: RemoteFilm = try await makeRequest(path: "\(type.rawValue)/\(id)")
      return response.toModel(type: type)
    },
    cast: { id, type in
      let response: CastResponse = try await makeRequest(path: "\(type.rawValue)/\(id)/credits")
      return response.cast.map(\.model)
    },
    clips: { id, type in
      let response: ClipResponse = try await makeRequest(path: "\(type.rawValue)/\(id)/videos")
      return response.results.map(\.model)
    }
  )

  private static func makeRequest<T: Decodable>(path: String) async throws -> T {
    let client = URLSessionAPIClient()
    let request = Request(path: path)
    let response: T = try await client.execute(request: request)
    return response
  }
}
