import Foundation

public enum FilmType: String, Sendable {
  case movie
  case serie = "tv"
}

public struct Film: Hashable, Identifiable, Sendable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  private let voteAverage: Double
  private let voteCount: Int
  public let releaseDateString: String
  public let overview: String
  public let genres: [String]?
  public let type: FilmType

  public init(
    id: Int,
    title: String,
    posterPath: String?,
    voteAgerage: Double,
    voteCount: Int,
    releaseDateString: String,
    overview: String,
    genres: [String]?,
    type: FilmType
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.voteCount = voteCount
    self.voteAverage = voteAgerage
    self.releaseDateString = releaseDateString
    self.overview = overview
    self.type = type
    self.genres = genres
  }

  public var formatedVoteAverage: String { String(format: "%.1f", voteAverage) }
  public var formatedVoteCount: String { "\(voteCount)" }

  public var releaseDateYear: String {
    releaseDate.formatted(.dateTime.year())
  }

  public var releaseDate: Date {
    let strategy = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    guard let date = try? Date(releaseDateString, strategy: strategy) else { return .now }
    return date
  }
}

extension Sequence<Film> {
  public func sanitize() -> [Film] {
    lazy
      .filter { $0.posterPath != nil }
      .sorted { $0.releaseDate > $1.releaseDate }
  }
}
