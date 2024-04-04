import CoreModels
import Foundation

public struct RemoteFilm: Decodable, Sendable {
  let id: Int
  let title: String?
  let posterPath: String?
  let voteAverage: Double
  let releaseDate: String?
  let voteCount: Int
  let overview: String?
  let name: String?
  let firstAirDate: String?
  let genres: [RemoteGenre]

  public func toModel(type: FilmType) -> Film {
    Film(
      id: id,
      title: title ?? name ?? "Unknow Movie/Serie",
      posterPath: posterPath,
      voteAgerage: voteAverage,
      voteCount: voteCount,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview ?? "",
      genres: genres.map(\.name),
      type: type
    )
  }
}
