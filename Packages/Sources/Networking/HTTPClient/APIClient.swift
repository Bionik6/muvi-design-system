import Foundation

public protocol APIClient {
  func execute<D: Decodable>(request: Request) async throws -> D
}

public class URLSessionAPIClient {
  private var session: URLSession
  private var baseURL = URL(string: "https://api.themoviedb.org/3/")!

  public init(session: URLSession = .shared) {
    self.session = session
  }

  public func execute<D: Decodable>(request: Request) async throws -> D {
    let sessionRequest = prepareURLRequest(for: request)
    let (data, response) = try await session.data(for: sessionRequest)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw NetworkError.unauthorized }
      if 400...599 ~= response.statusCode { throw NetworkError.serverError }
    }
    guard let object = try? decoder.decode(D.self, from: data) else {
      throw NetworkError.unprocessableData
    }
    return object
  }

  private func prepareURLRequest(for request: Request) -> URLRequest {
    let fullURL = baseURL.appendingPathComponent(request.path)

    var urlRequest = URLRequest(url: baseURL)
    urlRequest.httpMethod = request.method.rawValue

    let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]

    if let params = request.params {
      switch params {
      case .body(let bodyParams):
        let data = try? JSONEncoder().encode(bodyParams)
        urlRequest.httpBody = data
      case .url(let urlParams):
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        queryItems.append(contentsOf: urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
        components?.queryItems = queryItems
        urlRequest.url = components?.url
      }
    } else {
      let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
      var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
      components?.queryItems = queryItems
      urlRequest.url = components?.url
    }

    if let headers = request.headers {
      headers.forEach {
        urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
      }
    }

    urlRequest.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

    return urlRequest
  }

  private var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
}
