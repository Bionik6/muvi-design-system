import Foundation

public struct MoviesResponse: Decodable {
  public let results: [RemoteMovieSerie]
}

public struct SeriesResponse: Decodable {
  public let results: [RemoteMovieSerie]
}

public struct CastResponse: Decodable {
  public let cast: [RemoteActor]
}

public struct ClipResponse: Decodable {
  public let results: [RemoteClip]
}
