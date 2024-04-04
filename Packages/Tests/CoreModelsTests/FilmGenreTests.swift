import XCTest
import CoreModels

final class FilmGenreTests: XCTestCase {
  func test_sut_properties_are_well_initialized() {
    let sut = FilmGenre(id: 1, name: "Fantasy")

    XCTAssertEqual(sut.id, 1)
    XCTAssertEqual(sut.name, "Fantasy")
    XCTAssertEqual(sut.imageName, "fantasy")
  }
}
