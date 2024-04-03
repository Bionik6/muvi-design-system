import XCTest
import Networking

final class APIClientTests: XCTestCase {
  private let dummyURL = URL(string: "https://api.example.com/")!

  func testExecute_SuccessfulDataDecoding() async {
    // Mock data
    let mockData = """
           { "name": "Movie Name", "description": "A great movie" }
    """.data(using: .utf8)!
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(
        url: self.dummyURL,
        statusCode: 200,
        httpVersion: nil,
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, mockData)
    }
    
    let client = URLSessionAPIClient(session: mockSession)
    let request = Request(path: "/movies")
    
    do {
      let movie: Movie = try await client.execute(request: request)
      XCTAssertEqual(movie.name, "Movie Name")
      XCTAssertEqual(movie.description, "A great movie")
    } catch {
      XCTFail("We shouldn't have an error")
    }
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
