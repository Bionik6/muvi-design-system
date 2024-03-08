import SwiftUI

struct SummaryItem: View {
  let title: String
  let icon: Image?

  init(title: String, icon: Image? = nil) {
    self.title = title
    self.icon = icon
  }

  var body: some View {
    HStack(spacing: 4) {
      if let icon { icon }
      Text(title)
    }
    .font(CustomFont.caption1)
  }
}

#Preview {
  BaseContentView {
    VStack {
      SummaryItem(title: "Latest Release 2021", icon: nil)
      SummaryItem(title: "3.1k", icon: .Icon.eye)
    }
  }
  .loadCustomFonts()
}
