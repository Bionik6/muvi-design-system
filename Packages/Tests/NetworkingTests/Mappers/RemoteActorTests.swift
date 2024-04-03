import XCTest
@testable import Networking

final class RemoteActorTests: XCTestCase {

  func test_sut_can_map_to_model() {
    let actors: CastResponse = FixtureLoader.loadActors()
    do {
      let actor = try XCTUnwrap(actors.cast.first)
      let model = actor.model
      XCTAssertEqual(actor.id, model.id)
      XCTAssertEqual(actor.order, model.order)
      XCTAssertEqual(actor.originalName, model.realName)
      XCTAssertEqual(actor.character, model.characterName)
      XCTAssertEqual(actor.profilePath, model.profileImagePath)
    } catch {
      XCTFail("Actor should not be nil")
    }
  }
}
