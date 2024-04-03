import Foundation
import Networking

public enum FixtureLoader {
  private static func loadFixture<T: Decodable>(
    filename name: String,
    file: StaticString = #file,
    line: UInt = #line
  ) -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard
      let url = Bundle.module.url(forResource: name, withExtension: "json"),
      let data = try? Data(contentsOf: url),
      let object: T = try? decoder.decode(T.self, from: data)
    else {
      fatalError("could not load resource", file: file, line: line)
    }
    return object
  }
  
  public static func loadActors() -> CastResponse {
    loadFixture(filename: "actors")
  }
}
