import SwiftUI

struct PlayFilmButton: View {
  enum DisplayMode {
    case fixed
    case flexible
  }
  
  let title: LocalizedStringKey
  let displayMode: DisplayMode
  let action: () -> Void
  
  init(
    title: LocalizedStringKey,
    displayMode: DisplayMode = .fixed,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.displayMode = displayMode
    self.action = action
  }
  
  var body: some View {
    switch displayMode {
    case .fixed:
      fixedView
    case .flexible:
      flexibleView
    }
  }
  
  private var button: some View {
    Button(action: action, label: {
      Label(title, systemImage: "play.circle")
        .font(CustomFont.button)
        .foregroundStyle(ColorToken.white)
        .frame(height: Constants.height)
        .frame(maxWidth: .infinity)
        .background {
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(ColorToken.red100)
        }
    })
  }
  
  private var flexibleView: some View {
    Button(action: action, label: {
      Label(title, systemImage: "play.circle")
        .font(CustomFont.button)
        .foregroundStyle(ColorToken.white)
        .frame(height: Constants.height)
        .frame(maxWidth: .infinity)
        .background {
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(ColorToken.red100)
        }
    })
  }
  
  private var fixedView: some View {
    Button(action: action, label: {
      Label(title, systemImage: "play.circle")
        .font(CustomFont.button)
        .foregroundStyle(ColorToken.white)
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.horizontalPadding)
        .background {
          RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(ColorToken.red100)
        }
    })
  }
  
  enum Constants {
    static let iconSize = 14.0
    static let horizontalPadding = 16.0
    static let verticalPadding = 12.0
    static let cornerRadius = 4.0
    static let height = 40.0
  }
}

#Preview {
  BaseContentView {
    VStack {
      PlayFilmButton(title: "Play Now") {}
      PlayFilmButton(title: "Play Now", displayMode: .flexible) {}
    }
    .padding()
  }
  .loadCustomFonts()
}
