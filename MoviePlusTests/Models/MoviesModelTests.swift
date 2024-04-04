import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class MoviesModelTests: XCTestCase {
  @MainActor
  func test_sut_error_is_set_when_repository_throws_error() async {
    let sut = MoviesModel(repository: .noInternetConnectivityMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchMovies()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNotNil(sut.error)

    guard let error = sut.error as? NetworkError else {
      XCTFail("error should be a NetworkError")
      return
    }
    XCTAssertEqual(error, .noInternetConnectivity)

    XCTAssertEqual(sut.comingSoonMovies.count, 0)
    XCTAssertEqual(sut.topMovies.count, 0)
    XCTAssertEqual(sut.popularMovies.count, 0)
    XCTAssertEqual(sut.trendingMovies.count, 0)
  }

  @MainActor
  func test_sut_films_are_set_when_repository_sends_good_response() async {
    let sut = MoviesModel(repository: .happyPathMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchMovies()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    XCTAssertEqual(sut.comingSoonMovies.count, 2)
    XCTAssertEqual(sut.topMovies.count, 2)
    XCTAssertEqual(sut.popularMovies.count, 2)
    XCTAssertEqual(sut.trendingMovies.count, 2)
  }
}

extension MoviesRepository {
  static let noInternetConnectivityMock = Self(
    topMovies: { [] },
    upcomingMovies: { [Film.sample] },
    trendingMovies: { [] },
    latestMovies: { throw NetworkError.noInternetConnectivity },
    popularMovies: { [] }
  )

  static let happyPathMock = Self(
    topMovies: { [Film.sample, Film.sample] },
    upcomingMovies: { [Film.sample, Film.sample] },
    trendingMovies: { [Film.sample, Film.sample] },
    latestMovies: { [Film.sample, Film.sample] },
    popularMovies: { [Film.sample, Film.sample] }
  )
}
