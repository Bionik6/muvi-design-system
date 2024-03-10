import SwiftUI

struct ContentView: View {
  enum FilmTab: Hashable {
    case movies
    case series
    case genres
  }

  var body: some View {
    TabView {
      // MoviesView()
      Text("Movies")
        .tabItem { Label("Movies", systemImage: "play.tv.fill") }
        .tag(FilmTab.movies)

      // SeriesView()
      Text("TV Shows")
        .tabItem { Label("TV Shows", systemImage: "rectangle.stack.badge.play.fill") }
        .tag(FilmTab.series)

      // FilmGenresView()
      Text("Genres")
        .tabItem { Label("Genres", systemImage: "rectangle.grid.2x2.fill") }
        .tag(FilmTab.genres)
    }
  }
}

#Preview {
  ContentView()
}
