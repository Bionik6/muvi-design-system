import CoreUI
import SwiftUI
import CoreModels

@MainActor
struct FilmDetailsView: View {
  @State private var selection: Int = 1
  @State var model: FilmDetailsModel

  init(film: Film) {
    self.model = FilmDetailsModel(film: film)
  }

  var body: some View {
    BaseContentView {
      ScrollView {
        FilmDetailHero(
          title: model.film.title,
          posterPath: model.film.posterPath ?? "",
          releaseYear: model.film.releaseDateString,
          viewsNumber: "fldjkslfkds",
          vote: model.film.formatedVote,
          genres: model.genres,
          onPlayTrailerButtonTapped: {}
        ).ignoresSafeArea()

        GeneralSection {
          Text(model.film.overview)
        }

        GeneralSection {
          VStack(spacing: 16) {
            Picker("", selection: $selection) {
              Text("Cast").tag(1)
              Text("Clips").tag(2)
            }
            .pickerStyle(.segmented)

            if selection == 1 {
              FilmActorsListView(actors: model.cast.toActorUIModel)
            } else {
              FilmClipsListView(clips: model.clips.toClipUIModel(onTap: { clip in
                model.playFilmClip(for: clip)
              }))
            }
          }
        }
      }
    }
    .sheet(item: $model.selectedClip, content: { clip in
      FilmTrailerPlayer(videoId: clip.key)
    })
    .task { await model.fetchFilmDetails() }
    .navigationTitle("")
    .navigationBarHidden(true)
    .toolbar {
      ToolbarItem(placement: .cancellationAction) {
        Button(action: {}) {
          Image(systemName: "chevron.left")
            .font(.headline)
        }
      }
    }
    .navigationDestination(for: Film.self) { film in
      Text(film.title)
    }
  }
}

#Preview {
  NavigationStack {
    MoviesView()
      .loadCustomFonts()
  }
}
