import SwiftUI

public struct CastView: View {
  let actors: [ActorModel]
  private let actorGrid = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
  
  public var body: some View {
    ScrollView {
      LazyVGrid(columns: actorGrid, spacing: 24) {
        ForEach(actors) { actor in
          ActorView(
            posterPath: actor.posterPath,
            realName: actor.realName,
            characterName: actor.characterName
          )
        }
      }
    }
  }
}

extension CastView {
  public struct ActorModel: Equatable, Identifiable {
    public let id: UUID
    let posterPath: String
    let realName: String
    let characterName: String?
    
    public init(
      id: UUID,
      posterPath: String,
      realName: String,
      characterName: String?
    ) {
      self.id = id
      self.posterPath = posterPath
      self.realName = realName
      self.characterName = characterName
    }
  }
}

#Preview {
  BaseContentView {
    CastView(
      actors: [
        .init(
          id: UUID(),
          posterPath: "rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg",
          realName: "Jack Black",
          characterName: "Po (voice)"
        ),
        .init(
          id: UUID(),
          posterPath: "l5AKkg3H1QhMuXmTTmq1EyjyiRb.jpg",
          realName: "Awkwafina",
          characterName: "Zhen (voice)"
        ),
        .init(
          id: UUID(),
          posterPath: "xDssw6vpYNRjsybvMPRE30e0dPN.jpg",
          realName: "Viola Davis",
          characterName: "Chameleon (voice)"
        ),
      ]
    )
  }
}
