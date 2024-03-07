import CoreUI
import SwiftUI

@main
struct MoviePlusApp: App {
  init() {
    CustomFont.registerFonts()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
