import XCTest
import CoreModels

final class FilmTests: XCTestCase {
  func test_sut_properties_are_well_initialized() {
    let sut = makeSUT()

    XCTAssertEqual(sut.id, 1)
    XCTAssertEqual(sut.title, "Spiderman")
    XCTAssertEqual(sut.posterPath, "/poster-path")
    XCTAssertEqual(sut.overview, "a good movie")
    XCTAssertEqual(sut.genres, ["Fantasy", "Adventure"])
    XCTAssertEqual(sut.type, FilmType.movie)
  }

  func test_sut_formatedVoteAverage() {
    let sut = makeSUT()
    XCTAssertEqual(sut.formatedVoteAverage, "5.9")
  }

  func test_sut_formatedVoteCount() {
    let sut = makeSUT()
    XCTAssertEqual(sut.formatedVoteCount, "102")
  }

  func test_sut_releaseDate() {
    let sut = makeSUT()
    let calendar = Calendar.current
    let components = DateComponents(year: 2022, month: 04, day: 30)
    let date = calendar.date(from: components)
    XCTAssertTrue(calendar.isDate(date!, inSameDayAs: sut.releaseDate))
  }

  func test_sut_releaseDateYear() {
    let sut = makeSUT()
    XCTAssertEqual(sut.releaseDateYear, "2022")
  }

  func test_sut_sanitize() {
    let films = [
      makeSUT(id: 1, posterPath: "poster-path", releaseDate: "2022-04-25"),
      makeSUT(id: 2, posterPath: "poster-path", releaseDate: "2022-04-26"),
      makeSUT(id: 3, posterPath: nil, releaseDate: "2022-04-27"),
      makeSUT(id: 4, posterPath: "poster-path", releaseDate: "2022-04-28"),
    ]

    let sanitizedFilms = films.sanitize()

    XCTAssertEqual(sanitizedFilms.count, 3)
    XCTAssertEqual(sanitizedFilms, [
      makeSUT(id: 4, posterPath: "poster-path", releaseDate: "2022-04-28"),
      makeSUT(id: 2, posterPath: "poster-path", releaseDate: "2022-04-26"),
      makeSUT(id: 1, posterPath: "poster-path", releaseDate: "2022-04-25"),
    ])
  }
}

extension FilmTests {
  private func makeSUT(
    id: Int = 1,
    posterPath: String? = "/poster-path",
    releaseDate: String = "2022-04-30"
  ) -> Film {
    Film(
      id: id,
      title: "Spiderman",
      posterPath: posterPath,
      voteAgerage: 5.87,
      voteCount: 102,
      releaseDateString: releaseDate,
      overview: "a good movie",
      genres: ["Fantasy", "Adventure"],
      type: .movie
    )
  }
}
