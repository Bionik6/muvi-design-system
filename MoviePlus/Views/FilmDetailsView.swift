/*
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
           releaseYear: model.film.releaseDateYear,
           voteCount: model.film.formatedVoteCount,
           voteAverage: model.film.formatedVoteAverage,
           genres: model.genres,
           onPlayTrailerButtonTapped: model.playFilmTrailer
         )
         .ignoresSafeArea()
         .overlay(alignment: .topLeading) {
           dismissButton
         }

         GeneralSection {
           Paragraph(text: model.film.overview)
         }

         GeneralSection {
           VStack(spacing: 16) {
             Picker("", selection: $selection) {
               Text("Cast").tag(1)
               Text("Clips").tag(2)
             }
             .pickerStyle(.segmented)

             if selection == 1 {
               FilmActorsListView(actors: model.cast.toUIModel)
             } else {
               FilmClipsListView(
                 clips: model.clips.toUIModel,
                 onTap: { model.playFilmClip(for: $0.key) }
               )
             }
           }
         }
       }
     }
     .sheet(item: $model.selectedClip) { FilmClipPlayer(videoId: $0.key) }
     .sheet(isPresented: $model.playTrailer, content: {
       if let youtubeKey = model.filmTrailerKey {
         FilmClipPlayer(videoId: youtubeKey)
       }
     })
     .task { await model.fetchFilmDetails() }
     .navigationTitle("")
     .navigationBarHidden(true)
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
     FilmDetailsView(film: .sample)
       .loadCustomFonts()
   }
 }
 */
