import XCTest
import Networking

final class APIClientTests: XCTestCase {
  private let dummyURL = URL(string: "https://api.example.com/")!

  override func tearDown() {
    MockURLProtocol.error = nil
    MockURLProtocol.request = nil
    MockURLProtocol.requestHandler = nil
    super.tearDown()
  }

  func test_sut_decodes_data_successfully_after_getting_a_200_response() async {
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

  func test_sut_fails_to_decode_data_successfully_after_getting_a_200_response() async {
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

  func test_sut_throws_noInternet_NetworkError() async {
    MockURLProtocol.requestHandler = { _ in
      throw URLError(.notConnectedToInternet)
    }

    let client = URLSessionAPIClient(session: mockSession)
    let request = Request(path: "/movies")

    do {
      let _ = try await client.execute(request: request) as Movie
      XCTFail("Expected to throw NetworkError.noInternetConnectivity, but succeeded")
    } catch let error as NetworkError {
      XCTAssertEqual(error, NetworkError.noInternetConnectivity)
    } catch {
      XCTFail("Expected NetworkError.noInternetConnectivity, but received \(error)")
    }
  }
}

// MARK: - URLRequest Tests

extension APIClientTests {
  func testPrepareURLRequest_with_URLParams() async {
    makeDummyRequest()
    let client = URLSessionAPIClient(session: mockSession)

    let request = Request(
      path: "movies",
      method: .get,
      params: .url(["key1": "value1", "key2": 2]),
      headers: ["Authorization": "Bearer token"]
    )

    _ = try? await client.execute(request: request) as Movie

    do {
      let urlRequest = try XCTUnwrap(MockURLProtocol.request)
      XCTAssertEqual(urlRequest.httpMethod, "GET")
      XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
      XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Accept"), "application/json;charset=utf-8")
      XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer token")
      XCTAssertTrue(urlRequest.url?.absoluteString.contains("key1=value1") ?? false)
      XCTAssertTrue(urlRequest.url?.absoluteString.contains("key2=2") ?? false)
    } catch {
      XCTFail("URLRequest shouldn't be nil")
    }
  }

  func testPrepareURLRequest_with_BodyParams() async {
    makeDummyRequest()
    let client = URLSessionAPIClient(session: mockSession)

    let request = Request(
      path: "movies",
      method: .post,
      params: .body(Movie(name: "Spiderman", description: "A good movie"))
    )

    _ = try? await client.execute(request: request) as Movie

    do {
      let urlRequest = try XCTUnwrap(MockURLProtocol.request)
      XCTAssertEqual(urlRequest.httpMethod, "POST")
    } catch {
      XCTFail("URLRequest shouldn't be nil")
    }
  }
}

// MARK: - Helpers

extension APIClientTests {
  private func makeDummyRequest() {
    MockURLProtocol.requestHandler = { _ in
      let response = HTTPURLResponse(
        url: self.dummyURL,
        statusCode: 200,
        httpVersion: nil,
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, Data())
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

// MARK: - Mocks

extension APIClientTests {
  private class MockURLProtocol: URLProtocol {
    static var request: URLRequest?
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
      true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      self.request = request
      return request
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

    override func stopLoading() {}
  }

  private var mockSession: URLSession {
    let configuration: URLSessionConfiguration = .ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }

  private struct Movie: Codable {
    let name: String
    let description: String
  }
}
