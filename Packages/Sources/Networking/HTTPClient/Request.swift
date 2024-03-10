import Foundation

public struct Request {
  let path: String
  let method: HTTPMethod
  let params: RequestParams?
  let headers: [String: String]?

  public init(
    path: String,
    method: HTTPMethod = .get,
    params: RequestParams? = nil,
    headers: [String: String]? = nil
  ) {
    self.path = path
    self.method = method
    self.params = params
    self.headers = headers
  }
}
