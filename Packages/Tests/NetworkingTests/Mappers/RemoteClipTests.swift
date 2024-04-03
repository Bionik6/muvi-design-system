import XCTest
import CoreModels
@testable import Networking

final class RemoteClipTests: XCTestCase {
  func test_sut_is_correctly_decoded() {
    let clips: ClipResponse = FixtureLoader.loadClips()
    do {
      let sut = try XCTUnwrap(clips.results.first)
      XCTAssertEqual(sut.id, "65ebc0ca28723c01643e7dd4")
      XCTAssertEqual(sut.name, "This or That")
      XCTAssertEqual(sut.site, "YouTube")
      XCTAssertEqual(sut.key, "Xq6OPXGEzBo")
      XCTAssertEqual(sut.publishedAt, "2024-03-08T07:57:42.000Z")
    } catch {
      XCTFail("Clip should not be nil")
    }
  }

  func test_sut_can_map_to_model() {
    let clips: ClipResponse = FixtureLoader.loadClips()
    do {
      let sut = try XCTUnwrap(clips.results.first)
      let model = sut.model
      XCTAssertEqual(sut.id, model.id)
      XCTAssertEqual(sut.name, model.name)
      XCTAssertEqual(sut.site, ClipSite.youtube.rawValue)
      XCTAssertEqual(sut.key, model.key)
      XCTAssertEqual(sut.publishedAt, model.publishedDateString)
    } catch {
      XCTFail("Clip should not be nil")
    }
  }
}
