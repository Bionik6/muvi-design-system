import Foundation

public struct FilmActor: Sendable, Identifiable, Hashable {
  public let id: Int
  public let order: Int
  public let realName: String
  public let characterName: String?
  public let profileImagePath: String?

  public init(
    id: Int,
    order: Int,
    realName: String,
    characterName: String?,
    profileImagePath: String?
  ) {
    self.id = id
    self.order = order
    self.realName = realName
    self.characterName = characterName
    self.profileImagePath = profileImagePath
  }
}
