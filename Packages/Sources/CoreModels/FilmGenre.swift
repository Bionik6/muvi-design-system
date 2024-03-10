import Foundation

public struct FilmGenre: Identifiable, Hashable, Sendable {
  public let id: Int
  public let name: String

  public var imageName: String {
    name.lowercased()
  }

  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
