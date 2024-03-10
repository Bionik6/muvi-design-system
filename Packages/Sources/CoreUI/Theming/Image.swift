import SwiftUI

extension Image {
  enum Icon {
    static let eye = makeAssetImage("eye")
    static let star = makeAssetImage("star")
    static let play = makeSystemImage("play.circle")
    static let youtubePlay = makeSystemImage("play.rectangle.fill")
    static let person = makeSystemImage("person.fill")
    static let popcorn = makeSystemImage("popcorn.fill")
    static let plus = makeSystemImage("plus.app")
  }

  private static func makeSystemImage(_ systemName: String) -> Image {
    Image(systemName: systemName)
  }

  private static func makeAssetImage(_ assetName: String) -> Image {
    Image(assetName, bundle: .module)
  }
}
