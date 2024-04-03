import XCTest
import CoreModels
@testable import Networking

final class RemoteClipTests: XCTestCase {

  func test_sut_can_map_to_model() {
    let clips: ClipResponse = FixtureLoader.loadClips()
    do {
      let clip = try XCTUnwrap(clips.results.first)
      let model = clip.model
      XCTAssertEqual(clip.id, model.id)
      XCTAssertEqual(clip.name, model.name)
      XCTAssertEqual(clip.site, ClipSite.youtube.rawValue)
      XCTAssertEqual(clip.key, model.key)
      XCTAssertEqual(clip.publishedAt, model.publishedDateString)
    } catch {
      XCTFail("Clip should not be nil")
    }
  }

}
