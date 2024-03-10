import SwiftUI

public struct GeneralSection<Content: View>: View {
  private let title: LocalizedStringResource?
  private let buttonTapAction: (() -> Void)?
  private let content: Content

  public init(
    title: LocalizedStringResource? = nil,
    buttonTapAction: (() -> Void)? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.buttonTapAction = buttonTapAction
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      if let title {
        FilmHeader(
          title: title,
          onRightButtonTapped: buttonTapAction
        )
      }
      content
    }
    .padding(Constants.defaultPadding)
    .frame(maxWidth: .infinity)
  }
}

extension GeneralSection {
  public struct HeaderInfo {
    let title: LocalizedStringResource?
    let buttonTapAction: (() -> Void)?

    public init(
      title: LocalizedStringResource?,
      buttonTapAction: (() -> Void)? = nil
    ) {
      self.title = title
      self.buttonTapAction = buttonTapAction
    }
  }
}

private enum Constants {
  static let defaultPadding: EdgeInsets = .init(top: 24, leading: 16, bottom: 0, trailing: 16)
}

#Preview {
  BaseContentView {
    ScrollView {
      GeneralSection(title: "Most Popular") {
        Text("Hello")
      }
      GeneralSection(title: "Another section", buttonTapAction: {}) {
        Text("Testing")
      }
    }
    .loadCustomFonts()
  }
}
