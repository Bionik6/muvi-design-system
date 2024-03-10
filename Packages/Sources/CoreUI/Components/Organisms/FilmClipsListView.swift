import SwiftUI

public struct FilmClipsListView: View {
  let clips: [ClipUIModel]
  private let clipGrid = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

  public init(clips: [ClipUIModel]) {
    self.clips = clips
  }

  public var body: some View {
    LazyVGrid(columns: clipGrid, spacing: 16) {
      ForEach(clips) { clip in
        Button(action: clip.onTap) {
          FilmClip(title: clip.name, key: clip.key)
            .foregroundStyle(ColorToken.white)
        }
      }
    }
  }
}

extension FilmClipsListView {
  public struct ClipUIModel: Equatable, Identifiable {
    public let id: String
    let name: String
    let key: String
    let onTap: () -> Void

    public init(
      id: String,
      name: String,
      key: String,
      onTap: @escaping () -> Void
    ) {
      self.id = id
      self.name = name
      self.key = key
      self.onTap = onTap
    }

    public static func ==(lhs: FilmClipsListView.ClipUIModel, rhs: FilmClipsListView.ClipUIModel) -> Bool {
      lhs.id == rhs.id
    }
  }
}

#Preview {
  BaseContentView {
    FilmClipsListView(
      clips: [
        .init(
          id: "123",
          name: "This or That",
          key: "Xq6OPXGEzBo",
          onTap: {}
        ),
        .init(
          id: "1234",
          name: "Greig Fraser and the Cinematography of Dune",
          key: "39p8wPkhmtM",
          onTap: {}
        ),
        .init(
          id: "1235",
          name: "#1 Movie in the World - Now Playing",
          key: "tQucjg4-Q6M",
          onTap: {}
        ),
        .init(
          id: "12356",
          name: "Denis Villeneuve on Dune: Part Two",
          key: "N4StKUrf2ig",
          onTap: {}
        ),
      ]
    )
    .padding()
    .loadCustomFonts()
  }
}