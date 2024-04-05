import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class FilmModelTests: XCTestCase {
  private var mockFilms: [Film]!
  private var mockFilmModel: MockFilmModel!

  @MainActor
  override func setUp() {
    super.setUp()
    mockFilmModel = MockFilmModel()
    mockFilms = [Film.sample, Film.sample]
  }

  @MainActor
  override func tearDown() {
    mockFilmModel = nil
    mockFilms = nil
    super.tearDown()
  }

  @MainActor
  func testSelectFilmWithValidId() {
    let validId = 866398
    mockFilmModel.selectFilm(id: validId, in: mockFilms)

    XCTAssertNotNil(mockFilmModel.selectedFilm)
    XCTAssertEqual(mockFilmModel.selectedFilm?.id, validId)
  }

  @MainActor
  func testSelectFilmWithInvalidId() {
    let invalidId = 1
    mockFilmModel.selectFilm(id: invalidId, in: mockFilms)

    XCTAssertNil(mockFilmModel.selectedFilm)
  }

  @MainActor
  func testResetError() {
    mockFilmModel.error = NetworkError.noInternetConnectivity
    mockFilmModel.resetError()

    XCTAssertNil(mockFilmModel.error)
  }
}

extension FilmModelTests {
  @MainActor
  private class MockFilmModel: FilmModel {
    var selectedFilm: Film?
    var error: LocalizedError?
  }
}
