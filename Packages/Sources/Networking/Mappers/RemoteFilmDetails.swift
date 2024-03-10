import CoreModels
import Foundation

public struct RemoteFilmDetails: Decodable, Sendable {
  let id: Int
  let title: String?
  let posterPath: String
  let voteAverage: Double
  let voteCount: Int
  let releaseDate: String?
  let overview: String
  let name: String?
  let firstAirDate: String?
  let genres: [RemoteGenre]

  public func toModel(type: FilmType) -> FilmDetails {
    let film = Film(
      id: id,
      title: title ?? name ?? "Unknow Movie/Serie",
      posterPath: posterPath,
      voteAgerage: voteAverage,
      voteCount: voteCount,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview,
      type: type
    )
    return FilmDetails(film: film, genres: genres.map(\.name))
  }
}
