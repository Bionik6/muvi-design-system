import SwiftUI

public struct LoadingViewModifier: ViewModifier {
  private let title: String
  private let condition: Bool

  init(title: String? = nil, condition: Bool) {
    guard let title else {
      self.title = "Please wait"
      self.condition = condition
      return
    }
    self.title = title
    self.condition = condition
  }

  public func body(content: Content) -> some View {
    content.overlay(loadingOverlay)
  }

  @ViewBuilder private var loadingOverlay: some View {
    if condition {
      ZStack {
        ColorToken.blackBg100.ignoresSafeArea(.all)
        ProgressView {
          Text(verbatim: title)
            .font(CustomFont.body2)
            .foregroundStyle(ColorToken.white)
            .padding(.horizontal, 32)
        }
      }
    }
  }
}

extension View {
  public func loader(title: String? = nil, condition: Bool) -> some View {
    modifier(LoadingViewModifier(title: title, condition: condition))
  }
}
