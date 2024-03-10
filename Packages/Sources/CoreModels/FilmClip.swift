import Foundation

public enum ClipType: String, Sendable {
  case bloopers = "Bloopers"
  case trailer = "Trailer"
  case teaser = "Teaser"
  case bts = "Behind the Scenes"
  case clip = "Clip"
  case opening = "Opening Credits"
}

public enum ClipSite: String, Sendable {
  case youtube = "YouTube"
}

public struct FilmClip: Identifiable, Sendable {
  public let id: String
  public let name: String
  public let site: ClipSite?
  public let key: String
  public let type: ClipType?
  public let publishedDateString: String

  public init(
    id: String,
    name: String,
    site: ClipSite?,
    key: String,
    type: ClipType?,
    publishedDateString: String
  ) {
    self.id = id
    self.name = name
    self.site = site
    self.key = key
    self.type = type
    self.publishedDateString = publishedDateString
  }
}
