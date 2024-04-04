import XCTest
import CoreModels

final class FilmActorTests: XCTestCase {
  func test_sut_properties_are_well_initialized() {
    let sut = FilmActor(
      id: 1,
      order: 2,
      realName: "Jack Black",
      characterName: "Po",
      profileImagePath: "/image-path"
    )

    XCTAssertEqual(sut.id, 1)
    XCTAssertEqual(sut.order, 2)
    XCTAssertEqual(sut.realName, "Jack Black")
    XCTAssertEqual(sut.characterName, "Po")
    XCTAssertEqual(sut.profileImagePath, "/image-path")
  }
}
