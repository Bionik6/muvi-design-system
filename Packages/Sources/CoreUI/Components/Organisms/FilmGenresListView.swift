import SwiftUI

public struct FilmGenresListView: View {
  private let genres: [UIModel]
  private let onTap: (UIModel) -> Void
  private let genreGrid = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

  public init(
    genres: [UIModel],
    onTap: @escaping (UIModel) -> Void
  ) {
    self.genres = genres
    self.onTap = onTap
  }

  public var body: some View {
    ScrollView {
      LazyVGrid(columns: genreGrid, spacing: 16) {
        ForEach(genres) { genre in
          Button(action: { onTap(genre) }) {
            FilmGenre(
              name: genre.name,
              imageName: genre.imageName
            )
          }
        }
      }
    }
  }
}

extension FilmGenresListView {
  public struct UIModel: Identifiable {
    public let id: Int
    let name: String
    let imageName: String

    public init(
      id: Int,
      name: String,
      imageName: String
    ) {
      self.id = id
      self.name = name
      self.imageName = imageName
    }
  }
}

#Preview {
  BaseContentView {
    FilmGenresListView(
      genres: [
        .init(
          id: 1,
          name: "Action",
          imageName: "action"
        ),
        .init(
          id: 2,
          name: "Adventure",
          imageName: "adventure"
        ),
        .init(
          id: 3,
          name: "Fantasy",
          imageName: "fantasy"
        ),
        .init(
          id: 4,
          name: "Comedy",
          imageName: "comedy"
        ),
      ],
      onTap: { _ in }
    )
    .padding()
    .loadCustomFonts()
  }
}
