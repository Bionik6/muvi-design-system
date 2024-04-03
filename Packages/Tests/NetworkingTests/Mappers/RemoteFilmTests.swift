import XCTest
@testable import Networking

final class RemoteFilmTests: XCTestCase {
  func test_sut_is_correctly_decoded() {
    let sut = FixtureLoader.loadFilmDetails()

    XCTAssertEqual(sut.id, 943822)
    XCTAssertEqual(sut.title, "Prizefighter: The Life of Jem Belcher")
    XCTAssertEqual(sut.posterPath, "/x3PIk93PTbxT88ohfeb26L1VpZw.jpg")
    XCTAssertEqual(sut.releaseDate, "2022-06-30")
    XCTAssertEqual(sut.voteCount, 164)
    XCTAssertEqual(sut.voteAverage, 6.32)
    XCTAssertNil(sut.firstAirDate)
    XCTAssertNil(sut.name)
    XCTAssertEqual(
      sut.overview,
      """
      At the turn of the 19th century, Pugilism was the sport of kings and a gifted young boxer fought his way to becoming champion of England.
      """
    )
  }

  func test_sut_can_map_to_model() {
    let sut = FixtureLoader.loadFilmDetails()
    let model = sut.toModel(type: .movie)

    XCTAssertEqual(sut.id, model.id)
    XCTAssertEqual(sut.title, model.title)
    XCTAssertEqual(sut.posterPath, model.posterPath)
    XCTAssertEqual(sut.overview, model.overview)
  }
}
