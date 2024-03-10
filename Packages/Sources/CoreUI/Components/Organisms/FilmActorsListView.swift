import SwiftUI

public struct FilmActorsListView: View {
  let actors: [ActorUIModel]
  private let actorGrid = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 3)

  public init(actors: [ActorUIModel]) {
    self.actors = actors
  }

  public var body: some View {
    LazyVGrid(columns: actorGrid, spacing: 24) {
      ForEach(actors) { actor in
        FilmActor(
          posterPath: actor.posterPath,
          realName: actor.realName,
          characterName: actor.characterName
        )
      }
    }
  }
}

extension FilmActorsListView {
  public struct ActorUIModel: Equatable, Identifiable {
    public let id: Int
    let posterPath: String
    let realName: String
    let characterName: String?

    public init(
      id: Int,
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
    FilmActorsListView(
      actors: [
        .init(
          id: 1,
          posterPath: "rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg",
          realName: "Jack Black",
          characterName: "Po (voice)"
        ),
        .init(
          id: 2,
          posterPath: "l5AKkg3H1QhMuXmTTmq1EyjyiRb.jpg",
          realName: "Awkwafina",
          characterName: "Zhen (voice)"
        ),
        .init(
          id: 3,
          posterPath: "xDssw6vpYNRjsybvMPRE30e0dPN.jpg",
          realName: "Viola Davis",
          characterName: "Chameleon (voice)"
        ),
      ]
    )
    .loadCustomFonts()
  }
}
