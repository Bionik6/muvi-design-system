import OSLog
import Foundation
import CoreModels

@MainActor
let logger = Logger(subsystem: "dev.iciss.movieplus", category: "Movies")

@MainActor
protocol FilmModel: AnyObject {
  var error: LocalizedError? { get set }
  var selectedFilm: Film? { get set }
}

extension FilmModel {
  func selectFilm(id: Int, in films: [Film]) {
    guard let film = films.first(where: { $0.id == id }) else {
      logger.error("Couldn't find film with id: \(id)")
      return
    }
    selectedFilm = film
  }

  func resetError() {
    error = nil
  }
}
