import SwiftUI

public struct FilmGenresListView: View {
  private let genres: [FilmGenreUIModel]
  private let genreGrid = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)

  public init(genres: [FilmGenreUIModel]) {
    self.genres = genres
  }

  public var body: some View {
    LazyVGrid(columns: genreGrid, spacing: 16) {
      ForEach(genres) { genre in
        Button(action: { genre.onTap(genre.id) }) {
          FilmGenre(
            name: genre.name,
            imageName: genre.imageName
          )
        }
      }
    }
  }
}

extension FilmGenresListView {
  public struct FilmGenreUIModel: Equatable, Identifiable {
    public let id: Int
    let name: String
    let imageName: String
    let onTap: (Int) -> Void

    init(
      id: Int,
      name: String,
      imageName: String,
      onTap: @escaping (Int) -> Void
    ) {
      self.id = id
      self.name = name
      self.imageName = imageName
      self.onTap = onTap
    }

    public static func ==(lhs: FilmGenresListView.FilmGenreUIModel, rhs: FilmGenresListView.FilmGenreUIModel) -> Bool {
      lhs.id == rhs.id
    }
  }
}

#Preview {
  BaseContentView {
    ScrollView {
      FilmGenresListView(
        genres: [
          .init(
            id: 1,
            name: "Action",
            imageName: "action"
          ) { _ in },
          .init(
            id: 2,
            name: "Adventure",
            imageName: "adventure"
          ) { _ in },
          .init(
            id: 3,
            name: "Fantasy",
            imageName: "fantasy"
          ) { _ in },
          .init(
            id: 4,
            name: "Comedy",
            imageName: "comedy"
          ) { _ in },
        ]
      )
      .padding()
      .loadCustomFonts()
    }
  }
}
