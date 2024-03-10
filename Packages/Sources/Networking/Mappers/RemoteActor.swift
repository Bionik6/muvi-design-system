import CoreModels
import Foundation

public struct RemoteActor: Decodable, Sendable {
  let id: Int
  let order: Int
  let originalName: String
  let character: String?
  let profilePath: String?

  public var model: FilmActor {
    FilmActor(
      id: id,
      order: order,
      realName: originalName,
      characterName: character,
      profileImagePath: profilePath
    )
  }
}
