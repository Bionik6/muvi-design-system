import SwiftUI

public struct FilmActor: View {
  let posterPath: String
  let realName: String
  let characterName: String?

  init(
    posterPath: String,
    realName: String,
    characterName: String?
  ) {
    self.posterPath = posterPath
    self.realName = realName
    self.characterName = characterName
  }

  public var body: some View {
    VStack(spacing: 4) {
      ActorImage(posterPath: posterPath)
      Text(realName)
        .font(CustomFont.title3)
      if let characterName {
        Text("as " + characterName)
          .font(CustomFont.caption2)
          .foregroundStyle(ColorToken.black20)
      }
    }
    .multilineTextAlignment(.center)
  }
}

#Preview {
  BaseContentView {
    HStack {
      FilmActor(
        posterPath: "rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg",
        realName: "Ibrahima Ciss",
        characterName: "Bionik"
      )
    }
    .loadCustomFonts()
  }
}
