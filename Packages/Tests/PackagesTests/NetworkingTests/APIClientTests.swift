import XCTest
import Networking

final class APIClientTests: XCTestCase {
  private let dummyURL = URL(string: "https://api.example.com/")!

  func test_sut_decodes_data_successfully_when_getting_a_200_response() async {
    let mockData = """
           { "name": "Movie Name", "description": "A great movie" }
    """.data(using: .utf8)!
    let (client, request) = makeDummyRequest(from: mockData, statusCode: 200)

    do {
      let movie: Movie = try await client.execute(request: request)
      XCTAssertEqual(movie.name, "Movie Name")
      XCTAssertEqual(movie.description, "A great movie")
    } catch {
      XCTFail("We shouldn't have an error")
    }
  }

  func test_sut_fails_todecode_data_successfully_even_when_getting_a_200_response() async {
    let mockData = """
           { "name": "Movie Name", "description": null }
    """.data(using: .utf8)!

    let (client, request) = makeDummyRequest(from: mockData, statusCode: 200)

    do {
      _ = try await client.execute(request: request) as Movie
      XCTFail("Processing error should be thrown")
    } catch {
      guard let error = error as? NetworkError else {
        XCTFail("Unexpected error type")
        return
      }
      XCTAssertEqual(error, NetworkError.unprocessableData)
    }
  }

  func test_sut_throws_unauthorized_NetworkError_when_getting_401_status_from_server() async {
    let (client, request) = makeDummyRequest(from: Data(), statusCode: 401)

    do {
      _ = try await client.execute(request: request) as Movie
      XCTFail("Network error not thrown")
    } catch {
      guard let error = error as? NetworkError else {
        XCTFail("Unexpected error type")
        return
      }
      XCTAssertEqual(error, NetworkError.unauthorized)
    }
  }

  func test_sut_throws_unauthorized_NetworkError_when_getting_500_status_from_server() async {
    let (client, request) = makeDummyRequest(from: Data(), statusCode: 500)

    do {
      _ = try await client.execute(request: request) as Movie
      XCTFail("Network error not thrown")
    } catch {
      guard let error = error as? NetworkError else {
        XCTFail("Unexpected error type")
        return
      }
      XCTAssertEqual(error, NetworkError.serverError)
    }
  }

  private func makeDummyRequest(
    from data: Data,
    statusCode: Int
  ) -> (URLSessionAPIClient, Request) {
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(
        url: self.dummyURL,
        statusCode: statusCode,
        httpVersion: nil,
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, data)
    }

    let client = URLSessionAPIClient(session: mockSession)
    let request = Request(path: "/movies")

    return (client, request)
  }
}

// MARK: - Stubs

extension APIClientTests {
  private class MockURLProtocol: URLProtocol {
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
      true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      request
    }

    override func startLoading() {
      if let error = MockURLProtocol.error {
        client?.urlProtocol(self, didFailWithError: error)
        return
      }

      guard let handler = MockURLProtocol.requestHandler else {
        assertionFailure("Received unexpected request with no handler set")
        return
      }

      do {
        let (response, data) = try handler(request)
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
      } catch {
        client?.urlProtocol(self, didFailWithError: error)
      }
    }

    override func stopLoading() {
      // TODO: Andd stop loading here
    }
  }

  private var mockSession: URLSession {
    let configuration: URLSessionConfiguration = .ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }

  private struct Movie: Decodable {
    let name: String
    let description: String
  }
}
