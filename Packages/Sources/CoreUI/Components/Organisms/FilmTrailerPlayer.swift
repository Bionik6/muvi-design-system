import SwiftUI
import YouTubePlayerKit

public struct FilmTrailerPlayer: View {
  private let videoId: String

  private var playerConfiguration: YouTubePlayer.Configuration {
    var configuration = YouTubePlayer.Configuration()
    configuration.autoPlay = true
    configuration.allowsPictureInPictureMediaPlayback = true
    configuration.playInline = true
    return configuration
  }

  public init(videoId: String) {
    self.videoId = videoId
  }

  public var body: some View {
    YouTubePlayerView(
      YouTubePlayer(
        source: .video(id: videoId),
        configuration: playerConfiguration
      )
    )
  }
}

#Preview {
  FilmTrailerPlayer(videoId: "yAN5uspO_hk")
}
