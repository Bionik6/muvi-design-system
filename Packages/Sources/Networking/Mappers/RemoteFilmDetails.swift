import CoreModels
import Foundation

public struct RemoteFilmDetails: Decodable {
  struct Genre: Decodable {
    let id: Int
    let name: String
  }

  let id: Int
  let title: String?
  let posterPath: String
  let voteAverage: Double
  let releaseDate: String?
  let overview: String
  let name: String?
  let firstAirDate: String?
  let genres: [Genre]

  init(
    id: Int,
    title: String?,
    posterPath: String,
    voteAverage: Double,
    releaseDate: String,
    name: String?,
    overview: String,
    firstAirDate: String?,
    genres: [Genre]
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
    self.firstAirDate = firstAirDate
    self.genres = genres
  }

  public func toModel(type: FilmType) -> FilmDetails {
    let film = Film(
      id: id,
      title: title ?? name ?? "Unknow Movie/Serie",
      posterPath: posterPath,
      vote: voteAverage,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview,
      type: type
    )
    return FilmDetails(film: film, genres: genres.map(\.name))
  }
}
