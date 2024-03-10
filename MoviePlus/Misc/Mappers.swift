/*
 import CoreUI
 import Foundation
 import CoreModels

 extension [Film] {
   var toCarouselFilmUIModel: [FilmCarousel.UIModel] {
     map { film in
       FilmCarousel.UIModel(
         id: film.id,
         posterPath: film.posterPath ?? ""
       )
     }
   }

   var toUIModel: [FilmsListView.UIModel] {
     map { film in
       FilmsListView.UIModel(
         id: film.id,
         title: film.title,
         posterPath: film.posterPath ?? "",
         releaseYear: film.releaseDateYear,
         voteCount: film.formatedVoteCount,
         voteAverage: film.formatedVoteAverage
       )
     }
   }
 }

 extension [CoreModels.FilmActor] {
   var toUIModel: [FilmActorsListView.UIModel] {
     map { actor in
       FilmActorsListView.UIModel(
         id: actor.id,
         posterPath: actor.profileImagePath ?? "",
         realName: actor.realName,
         characterName: actor.characterName
       )
     }
   }
 }

 extension [FilmClip] {
   var toUIModel: [FilmClipsListView.UIModel] {
     map { clip in
       FilmClipsListView.UIModel(
         id: clip.id,
         name: clip.name,
         key: clip.key
       )
     }
   }
 }

 extension [FilmGenre] {
   var toUIModel: [FilmGenresListView.UIModel] {
     map { genre in
       FilmGenresListView.UIModel(
         id: genre.id,
         name: genre.name,
         imageName: genre.imageName
       )
     }
   }
 }
 */
