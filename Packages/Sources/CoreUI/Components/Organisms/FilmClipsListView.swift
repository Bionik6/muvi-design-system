import SwiftUI

public struct FilmClipsListView: View {
  let clips: [UIModel]
  let onTap: (UIModel) -> Void
  private let clipGrid = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

  public init(
    clips: [UIModel],
    onTap: @escaping (UIModel) -> Void
  ) {
    self.clips = clips
    self.onTap = onTap
  }

  public var body: some View {
    LazyVGrid(columns: clipGrid, spacing: 16) {
      ForEach(clips) { clip in
        Button(action: { onTap(clip) }) {
          FilmClip(title: clip.name, key: clip.key)
            .foregroundStyle(ColorToken.white)
        }
      }
    }
  }
}

extension FilmClipsListView {
  public struct UIModel: Identifiable {
    public let id: String
    public let name: String
    public let key: String

    public init(
      id: String,
      name: String,
      key: String
    ) {
      self.id = id
      self.name = name
      self.key = key
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
          key: "Xq6OPXGEzBo"
        ),
        .init(
          id: "1234",
          name: "Greig Fraser and the Cinematography of Dune",
          key: "39p8wPkhmtM"
        ),
        .init(
          id: "1235",
          name: "#1 Movie in the World - Now Playing",
          key: "tQucjg4-Q6M"
        ),
        .init(
          id: "12356",
          name: "Denis Villeneuve on Dune: Part Two",
          key: "N4StKUrf2ig"
        ),
      ],
      onTap: { _ in
      }
    )
    .padding()
    .loadCustomFonts()
  }
}
