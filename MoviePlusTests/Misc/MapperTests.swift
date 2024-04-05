import XCTest
import CoreUI
import Networking
import CoreModels
@testable import MoviePlus

final class MapperTests: XCTestCase {
  func test_Film_toCarouselFilmUIModel() {
    let films: [Film] = Array(repeating: .sample, count: 2)

    let uiModels = films.toCarouselFilmUIModel

    XCTAssertEqual(uiModels.count, films.count)
    XCTAssertEqual(uiModels.first?.id, 866398)
    XCTAssertEqual(uiModels.first?.posterPath, "/A7EByudX0eOzlkQ2FIbogzyazm2.jpg")
  }

  func test_Film_toUIModel() {
    let films: [Film] = Array(repeating: .sample, count: 3)

    let uiModels = films.toUIModel

    XCTAssertEqual(uiModels.count, films.count)
    XCTAssertEqual(uiModels.first?.id, 866398)
    XCTAssertEqual(uiModels.first?.posterPath, "/A7EByudX0eOzlkQ2FIbogzyazm2.jpg")
    XCTAssertEqual(uiModels.first?.title, "The Beekeeper")
    XCTAssertEqual(uiModels.first?.releaseYear, "2024")
    XCTAssertEqual(uiModels.first?.voteCount, "1591")
    XCTAssertEqual(uiModels.first?.voteAverage, "7.5")
  }

  func test_FilmActor_toUIModel() {
    let actors: [CoreModels.FilmActor] = Array(repeating: .sample, count: 5)

    let uiModels = actors.toUIModel

    XCTAssertEqual(uiModels.count, actors.count)
    XCTAssertEqual(uiModels.first?.id, 1)
    XCTAssertEqual(uiModels.first?.posterPath, "/x3PIk93PTbxT88ohfeb26L1VpZw.jpg")
    XCTAssertEqual(uiModels.first?.realName, "Jack Black")
    XCTAssertEqual(uiModels.first?.characterName, "Po")
  }

  func test_FilmClip_toUIModel() {
    let clips: [FilmClip] = Array(repeating: .sample, count: 4)

    let uiModels = clips.toUIModel

    XCTAssertEqual(uiModels.count, clips.count)
    XCTAssertEqual(uiModels.first?.id, "65e798aeea4263014820ffec")
    XCTAssertEqual(uiModels.first?.name, "Director Denis Villenueve talks Dune Part Two")
    XCTAssertEqual(uiModels.first?.key, "asTOTXj5AtI")
  }

  func test_FilmGenre_toUIModel() {
    let uiModels = filmGenres.toUIModel

    XCTAssertEqual(uiModels.count, filmGenres.count)
    XCTAssertEqual(uiModels.first?.id, 28)
    XCTAssertEqual(uiModels.first?.name, "Action")
    XCTAssertEqual(uiModels.first?.imageName, "action")
  }
}
