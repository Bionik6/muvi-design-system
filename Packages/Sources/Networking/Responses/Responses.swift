import Foundation

public struct FilmsResponse: Decodable {
  public let results: [RemoteFilm]
}

public struct CastResponse: Decodable {
  public let cast: [RemoteActor]
}

public struct ClipResponse: Decodable {
  public let results: [RemoteClip]
}
