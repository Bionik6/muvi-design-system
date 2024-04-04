import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class FilmGenresModelTests: XCTestCase {
  @MainActor
  func testSelectGenreWithValidId() {
    let model = FilmGenresModel()

    XCTAssertNil(model.selectedGenre)

    model.selectGenre(with: 28)

    XCTAssertNotNil(model.selectedGenre)
    XCTAssertEqual(model.selectedGenre?.id, 28)
  }

  @MainActor
  func testSelectGenreWithInvalidId() {
    let model = FilmGenresModel()

    XCTAssertNil(model.selectedGenre)

    model.selectGenre(with: 1)

    XCTAssertNil(model.selectedGenre)
  }
}
