import Foundation

public struct FilmDetails {
  public let film: Film
  public let genres: [String]

  public init(film: Film, genres: [String]) {
    self.film = film
    self.genres = genres
  }
}
