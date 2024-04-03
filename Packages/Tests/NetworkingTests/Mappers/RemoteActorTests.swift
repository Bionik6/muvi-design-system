import XCTest
@testable import Networking

final class RemoteActorTests: XCTestCase {
  func test_sut_is_correctly_decoded() {
    let actors: CastResponse = FixtureLoader.loadActors()
    do {
      let sut = try XCTUnwrap(actors.cast.first)
      XCTAssertEqual(sut.id, 70851)
      XCTAssertEqual(sut.order, 0)
      XCTAssertEqual(sut.originalName, "Jack Black")
      XCTAssertEqual(sut.character, "Po (voice)")
      XCTAssertEqual(sut.profilePath, "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg")
    } catch {
      XCTFail("Actor should not be nil")
    }
  }

  func test_sut_can_map_to_model() {
    let actors: CastResponse = FixtureLoader.loadActors()
    do {
      let sut = try XCTUnwrap(actors.cast.first)
      let model = sut.model
      XCTAssertEqual(sut.id, model.id)
      XCTAssertEqual(sut.order, model.order)
      XCTAssertEqual(sut.originalName, model.realName)
      XCTAssertEqual(sut.character, model.characterName)
      XCTAssertEqual(sut.profilePath, model.profileImagePath)
    } catch {
      XCTFail("Actor should not be nil")
    }
  }
}
