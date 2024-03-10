import SwiftUI

public struct BaseContentView<Content: View>: View {
  private let content: Content

  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  public var body: some View {
    ZStack {
      ColorToken.blackBg100.ignoresSafeArea()
      content
    }
    .preferredColorScheme(.dark)
  }
}

#Preview {
  BaseContentView {
    Text("Hello AppDevCon")
  }
}
