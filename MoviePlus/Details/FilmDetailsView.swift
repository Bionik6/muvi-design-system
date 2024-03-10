import CoreUI
import SwiftUI
import CoreModels

@MainActor
struct FilmDetailsView: View {
  @Environment(\.dismiss) var dismiss
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
        )
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
          dismissButton
        }

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
              FilmClipsListView(
                clips: model.clips.toClipUIModel,
                onTap: { model.playFilmClip(for: $0.key) }
              )
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
    .navigationDestination(for: Film.self) { film in
      Text(film.title)
    }
  }

  var dismissButton: some View {
    Button(action: { dismiss() }) {
      Image(systemName: "chevron.left")
        .font(.title2)
        .padding(.all, 24)
    }
  }
}

#Preview {
  NavigationStack {
    MoviesView()
      .loadCustomFonts()
  }
}
