import XCTest
import Networking
import CoreModels
@testable import MoviePlus

final class SeriesModelTests: XCTestCase {
  @MainActor
  func test_sut_error_is_set_when_repository_throws_error() async {
    let sut = SeriesModel(repository: .unauthorizedMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchSeries()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNotNil(sut.error)

    guard let error = sut.error as? NetworkError else {
      XCTFail("error should be a NetworkError")
      return
    }
    XCTAssertEqual(error, .unauthorized)

    XCTAssertTrue(sut.airingTodaySeries.isEmpty)
    XCTAssertTrue(sut.trendingSeries.isEmpty)
    XCTAssertTrue(sut.topRatedSeries.isEmpty)
    XCTAssertTrue(sut.popularSeries.isEmpty)
  }

  @MainActor
  func test_sut_films_are_set_when_repository_sends_good_response() async {
    let sut = SeriesModel(repository: .happyPathMock)

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    await sut.fetchSeries()

    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)

    XCTAssertEqual(sut.airingTodaySeries.count, 2)
    XCTAssertEqual(sut.trendingSeries.count, 2)
    XCTAssertEqual(sut.topRatedSeries.count, 2)
    XCTAssertEqual(sut.popularSeries.count, 2)
  }
}

private extension SeriesRepository {
  static let unauthorizedMock = Self(
    popularSeries: { [] },
    trendingSeries: { [Film.sample] },
    topRatedSeries: { [] },
    airingTodaySeries: { throw NetworkError.unauthorized }
  )

  static let happyPathMock = Self(
    popularSeries: { [Film.sample, Film.sample] },
    trendingSeries: { [Film.sample, Film.sample] },
    topRatedSeries: { [Film.sample, Film.sample] },
    airingTodaySeries: { [Film.sample, Film.sample] }
  )
}
