import CoreModels
import Foundation

public struct RemoteClip: Decodable {
  let name: String
  let site: String
  let key: String
  let type: String
  let publishedAt: String

  public var model: MovieClip {
    MovieClip(
      name: name,
      site: ClipSite(rawValue: site),
      key: key,
      type: ClipType(rawValue: type),
      publishedDateString: publishedAt
    )
  }
}
