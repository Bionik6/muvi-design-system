import Foundation

public struct FilmsResponse: Decodable, Sendable {
  public let results: [RemoteFilm]
}

public struct CastResponse: Decodable, Sendable {
  public let cast: [RemoteActor]
}

public struct ClipResponse: Decodable, Sendable {
  public let results: [RemoteClip]
}
