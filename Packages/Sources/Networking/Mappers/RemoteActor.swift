import CoreModels
import Foundation

public struct RemoteActor: Decodable {
  let id: Int
  let order: Int
  let originalName: String
  let character: String?
  let profilePath: String?

  public var model: MovieActor {
    MovieActor(
      id: id,
      order: order,
      realName: originalName,
      characterName: character,
      profileImagePath: profilePath
    )
  }
}
