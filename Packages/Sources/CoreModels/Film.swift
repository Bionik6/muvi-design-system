import Foundation

public enum FilmType: String, Sendable {
  case movie
  case serie = "tv"
}

public struct Film: Hashable, Identifiable, Sendable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  private let vote: Double
  public let releaseDateString: String
  public let overview: String
  public let type: FilmType

  public init(
    id: Int,
    title: String,
    posterPath: String?,
    vote: Double,
    releaseDateString: String,
    overview: String,
    type: FilmType
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.vote = vote
    self.releaseDateString = releaseDateString
    self.overview = overview
    self.type = type
  }

  public var formatedVote: String { String(format: "%.1f", vote) }

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
