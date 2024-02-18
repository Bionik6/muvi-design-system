import Foundation

public enum NetworkError: LocalizedError, Equatable {
  case noInternetConnectivity
  case notDetermined
  case unauthorized
  case unprocessableData
  case serverError

  public var failureReason: String? {
    switch self {
    case .noInternetConnectivity:
      "Please verify your internet connectivity."
    case .unauthorized:
      "API Key not valid or not provided"
    case .unprocessableData:
      "Cannot decode data"
    case .serverError, .notDetermined:
      "Something wrong happens, please retry later."
    }
  }

  public static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
    lhs.failureReason == rhs.failureReason
  }
}
