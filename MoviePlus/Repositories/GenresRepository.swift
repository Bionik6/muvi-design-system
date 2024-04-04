import CoreModels
import Foundation
import Networking

struct GenresRepository: Sendable {
  let filmsByGenre: @Sendable (Int, Int) async throws -> [Film]

  static let live = Self { genreId, page in
    let client = URLSessionAPIClient()
    let params = RequestParams.url(["page": page])
    let path = "genre/\(genreId)/movies"
    let request = Request(path: path, params: params)
    let response: FilmsResponse = try await client.execute(request: request)
    return response.results.map { $0.toModel(type: .movie) }
  }
}
