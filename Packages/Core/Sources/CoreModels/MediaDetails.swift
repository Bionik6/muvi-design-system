import Foundation

public struct MediaDetails {
  public let media: MovieSerie
  public let genres: [String]

  public init(media: MovieSerie, genres: [String]) {
    self.media = media
    self.genres = genres
  }
}
