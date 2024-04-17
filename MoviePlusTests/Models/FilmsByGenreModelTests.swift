import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class FilmsByGenreModelTests: XCTestCase {
  @MainActor
  func test_sut_is_correctly_initilazed() {
    let genre = FilmGenre(id: 1, name: "Action")
    let model = FilmsByGenreModel(genre: genre)

    XCTAssertEqual(model.genre, genre)
  }

  @MainActor
  func test_sut_error_is_set_when_repository_throws_error() async {
    let sut = makeSUT(repository: .unauthorizedMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchFilms()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNotNil(sut.error)

    guard let error = sut.error as? NetworkError else {
      XCTFail("error should be a NetworkError")
      return
    }
    XCTAssertEqual(error, .unprocessableData)

    XCTAssertTrue(sut.films.isEmpty)
  }

  @MainActor
  func test_sut_films_are_set_when_repository_sends_good_response() async {
    let sut = makeSUT(repository: .happyPathMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchFilms()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    XCTAssertEqual(sut.films.count, 2)
  }
  
  @MainActor
  func test_sut_pages_increment_on_successful_response() async {
    let sut = makeSUT(repository: .happyPathMock)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    
    await sut.fetchFilms()
    XCTAssertEqual(sut.page, 1)
    XCTAssertEqual(sut.films.count, 2)
    
    await sut.fetchFilms()
    XCTAssertEqual(sut.page, 2)
    XCTAssertEqual(sut.films.count, 4)
    
    await sut.fetchFilms()
    XCTAssertEqual(sut.page, 3)
    XCTAssertEqual(sut.films.count, 6)
  }

  @MainActor
  private func makeSUT(repository: GenresRepository) -> FilmsByGenreModel {
    let genre = FilmGenre(id: 1, name: "Action")
    return FilmsByGenreModel(genre: genre, repository: repository)
  }
}

private extension GenresRepository {
  static let unauthorizedMock = Self(
    filmsByGenre: { _, _ in throw NetworkError.unprocessableData }
  )

  static let happyPathMock = Self(
    filmsByGenre: { _, _ in [Film.sample, Film.sample] }
  )
}
