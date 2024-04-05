import SwiftUI

public struct ErrorAlert: ViewModifier {
  private let error: LocalizedError?
  private let action: () -> Void

  init(error: LocalizedError?, action: @escaping () -> Void) {
    self.error = error
    self.action = action
  }

  public func body(content: Content) -> some View {
    content
      .alert(isPresented: .constant(error != nil)) {
        Alert(
          title: Text(error?.errorDescription ?? "Erreur"),
          message: Text(error?.failureReason ?? ""),
          dismissButton: .default(Text("OK")) { action() }
        )
      }
  }
}

public extension View {
  func errorAlert(error: LocalizedError?, action: @escaping () -> Void) -> some View {
    modifier(ErrorAlert(error: error, action: action))
  }
}
