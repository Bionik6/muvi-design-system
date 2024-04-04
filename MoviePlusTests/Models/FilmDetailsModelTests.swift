import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class FilmDetailsModelTests: XCTestCase {
 
  @MainActor
  func test_sut_is_correctly_initilazed() {
    let film = Film.sample
    let model = FilmDetailsModel(film: film)
    
    XCTAssertEqual(model.film, film)
  }
  
  @MainActor
  func test_sut_error_is_set_when_repository_throws_error() async {
    let sut = makeSUT(repository: .serverErrorMock)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    
    await sut.fetchFilmDetails()
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNotNil(sut.error)
    
    guard let error = sut.error as? NetworkError else {
      XCTFail("error should be a NetworkError")
      return
    }
    XCTAssertEqual(error, .serverError)
    
    XCTAssertTrue(sut.cast.isEmpty)
    XCTAssertTrue(sut.clips.isEmpty)
    XCTAssertTrue(sut.genres.isEmpty)
  }
  
  @MainActor
  func test_sut_films_are_set_when_repository_sends_good_response() async {
    let sut = makeSUT(repository: .happyPathMock)
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    
    await sut.fetchFilmDetails()
    
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    
    XCTAssertEqual(sut.cast.count, 3)
    XCTAssertEqual(sut.clips.count, 3)
    XCTAssertEqual(sut.genres.count, 2)
  }
  
  @MainActor
  func test_sut_plays_filmClip_selection() async {
    let film = Film.sample
    let key = "asTOTXj5AtI"
    let sut = makeSUT(repository: .happyPathMock)
   
    XCTAssertNil(sut.selectedClip)
    
    await sut.fetchFilmDetails()
    
    sut.playFilmClip(for: key)
    
    XCTAssertNotNil(sut.selectedClip)
    XCTAssertEqual(sut.selectedClip?.key, key)
  }
  
  @MainActor
  func test_sut_plays_filmTrailer() async {
    let sut = makeSUT(repository: .happyPathMock)
    
    XCTAssertFalse(sut.playTrailer)
    
    sut.playFilmTrailer()
    
    XCTAssertTrue(sut.playTrailer)
  }
  
  @MainActor
  private func makeSUT(repository: FilmDetailsRepository) -> FilmDetailsModel {
    let film = Film.sample
    return FilmDetailsModel(film: film, repository: repository)
  }
}

private extension FilmDetailsRepository {
  static let serverErrorMock = Self(
    details: {_, _ in Film.sample },
    cast: {_, _ in throw NetworkError.serverError },
    clips: {_ , _ in [] }
  )
  
  static let happyPathMock = Self(
    details: {_, _ in Film.sample},
    cast: {_, _ in Array(repeating: FilmActor.sample, count: 3) },
    clips: {_, _ in Array(repeating: FilmClip.sample, count: 3) }
  )
}
