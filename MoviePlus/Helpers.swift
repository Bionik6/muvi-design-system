import CoreUI
import Foundation
import CoreModels

extension [Film] {
  func toCarouselFilmUIModel(onTap: @escaping (Film) -> Void) -> [FilmCarousel.FilmUIModel] {
    map { film in
      FilmCarousel.FilmUIModel(
        id: film.id,
        posterPath: film.posterPath ?? "",
        genres: [],
        releaseYear: film.releaseDateYear,
        onTap: { onTap(film) }
      )
    }
  }

  func toFilmListUIModel(onTap: @escaping (Film) -> Void) -> [FilmsListView.FilmUIModel] {
    map { film in
      FilmsListView.FilmUIModel(
        id: film.id,
        title: film.title,
        posterPath: film.posterPath ?? "",
        releaseYear: film.releaseDateYear,
        viewsNumber: "4243242",
        vote: film.formatedVote,
        onTap: { onTap(film) }
      )
    }
  }
}

extension [CoreModels.FilmActor] {
  var toActorUIModel: [FilmActorsListView.ActorUIModel] {
    map { actor in
      FilmActorsListView.ActorUIModel(
        id: actor.id,
        posterPath: actor.profileImagePath ?? "",
        realName: actor.realName,
        characterName: actor.characterName
      )
    }
  }
}

extension [FilmClip] {
  func toClipUIModel(onTap: @escaping (FilmClip) -> Void) -> [FilmClipsListView.ClipUIModel] {
    map { clip in
      FilmClipsListView.ClipUIModel(
        id: clip.id,
        name: clip.name,
        key: clip.key,
        onTap: { onTap(clip) }
      )
    }
  }
}
