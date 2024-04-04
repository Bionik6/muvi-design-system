import XCTest
import CoreModels
@testable import Networking

final class RemoteFilmDetailsTests: XCTestCase {
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
    XCTAssertEqual(sut.genres.map(\.id), [36, 18])
    XCTAssertEqual(sut.genres.map(\.name), ["History", "Drama"])
    XCTAssertEqual(
      sut.overview,
      """
      At the turn of the 19th century, Pugilism was the sport of kings and a gifted young boxer fought his way to becoming champion of England.
      """
    )
  }
}
