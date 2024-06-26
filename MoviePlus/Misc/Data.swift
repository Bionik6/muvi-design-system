import CoreModels

let filmGenres: [FilmGenre] = [
  FilmGenre(id: 28, name: "Action"),
  FilmGenre(id: 12, name: "Adventure"),
  FilmGenre(id: 35, name: "Comedy"),
  FilmGenre(id: 18, name: "Drama"),
  FilmGenre(id: 14, name: "Fantasy"),
  FilmGenre(id: 10749, name: "Romance"),
]

extension Film {
  static var sample: Self {
    Film(
      id: 866398,
      title: "The Beekeeper",
      posterPath: "/A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
      voteAgerage: 7.454,
      voteCount: 1591,
      releaseDateString: "2024-01-10",
      overview: "One man’s campaign for vengeance takes on national stakes after he is revealed to be a former operative of a powerful and clandestine organization known as Beekeepers.",
      genres: ["Adventure", "Fantasy"],
      type: .movie
    )
  }
}

extension FilmActor {
  static var sample: Self {
    FilmActor(
      id: 1,
      order: 2,
      realName: "Jack Black",
      characterName: "Po",
      profileImagePath: "/x3PIk93PTbxT88ohfeb26L1VpZw.jpg"
    )
  }
}

extension FilmClip {
  static var sample: Self {
    FilmClip(
      id: "65e798aeea4263014820ffec",
      name: "Director Denis Villenueve talks Dune Part Two",
      site: .youtube,
      key: "asTOTXj5AtI",
      type: .clip,
      publishedDateString: "2024-03-01T21:16:46.000Z"
    )
  }
}
