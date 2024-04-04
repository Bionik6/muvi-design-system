import XCTest
import CoreModels

final class FilmClipTests: XCTestCase {
  func test_sut_properties_are_well_initialized() {
    let sut = FilmClip(
      id: "id",
      name: "official movie trailer",
      site: .youtube,
      key: "key",
      type: .trailer,
      publishedDateString: "2024-04-04"
    )

    XCTAssertEqual(sut.id, "id")
    XCTAssertEqual(sut.name, "official movie trailer")
    XCTAssertEqual(sut.site, ClipSite.youtube)
    XCTAssertEqual(sut.key, "key")
    XCTAssertEqual(sut.type, ClipType.trailer)
    XCTAssertEqual(sut.publishedDateString, "2024-04-04")
  }
}
