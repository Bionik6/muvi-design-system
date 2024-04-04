import Foundation
import Networking

enum FixtureLoader {
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

  static func loadActors() -> CastResponse {
    loadFixture(filename: "actors")
  }

  static func loadClips() -> ClipResponse {
    loadFixture(filename: "clips")
  }

  static func loadFilmDetails() -> RemoteFilm {
    loadFixture(filename: "film_details")
  }
}
