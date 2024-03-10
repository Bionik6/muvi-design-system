import CoreUI
import SwiftUI

@MainActor
struct FilmGenresView: View {
  @State private var model = FilmGenresModel()

  var body: some View {
    NavigationStack {
      BaseContentView {
        ScrollView {
          GeneralSection {
            FilmGenresListView(
              genres: filmGenres.toUIModel,
              onTap: { genre in model.selectGenre(with: genre.id) }
            )
          }
        }
      }
      .navigationDestination(item: $model.selectedGenre, destination: { genre in
        FilmsByGenreView(genre: genre)
      })
      .navigationTitle("Genres")
    }
  }
}

#Preview {
  FilmGenresView()
    .loadCustomFonts()
}
