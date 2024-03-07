import SwiftUI

extension Image {
  enum Icon {
    static let eye = makeAssetImage("eye")
    static let star = makeAssetImage("star")
    static let play = makeAssetImage("play")
  }

  private static func makeSystemImage(_ systemName: String) -> Image {
    Image(systemName: systemName)
  }

  private static func makeAssetImage(_ assetName: String) -> Image {
    Image(assetName, bundle: .module)
  }
}
