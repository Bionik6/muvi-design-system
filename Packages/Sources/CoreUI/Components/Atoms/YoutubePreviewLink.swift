import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

@Observable
final class YoutubeLinkPreviewModel {
  var image: UIImage?
  let url: URL

  init(_ key: String) {
    guard let url = URL(string: "https://www.youtube.com/watch?v=\(key)") else {
      fatalError("Can't form URL")
    }
    self.url = url
    fetchMetadata()
  }

  private func fetchMetadata() {
    let provider = LPMetadataProvider()
    Task {
      let metadata = try await provider.startFetchingMetadata(for: url)
      image = try await convertToImage(metadata.imageProvider)
    }
  }

  private func convertToImage(_ imageProvider: NSItemProvider?) async throws -> UIImage? {
    var image: UIImage?

    if let imageProvider {
      let type = String(describing: UTType.image)

      if imageProvider.hasItemConformingToTypeIdentifier(type) {
        let item = try await imageProvider.loadItem(forTypeIdentifier: type)
        if item is UIImage {
          image = item as? UIImage
        }
        if item is URL {
          guard let url = item as? URL,
                let data = try? Data(contentsOf: url) else { return nil }
          image = UIImage(data: data)
        }

        if item is Data {
          guard let data = item as? Data else { return nil }
          image = UIImage(data: data)
        }
      }
    }
    return image
  }
}

struct YoutubeLinkView: View {
  @State var model: YoutubeLinkPreviewModel

  init(key: String) {
    self._model = State(initialValue: YoutubeLinkPreviewModel(key))
  }

  var body: some View {
    if let image = model.image {
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 94)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
          Image(systemName: "play.circle")
            .font(.system(size: Constants.imageSize))
            .foregroundStyle(ColorToken.white)
        }
    } else {
      RoundedRectangle(cornerRadius: Constants.imageCornerRadius)
        .frame(height: 94)
        .foregroundStyle(ColorToken.black20)
        .overlay {
          Image(systemName: "play.rectangle.fill")
            .font(.system(size: Constants.imageSize))
            .foregroundStyle(ColorToken.black60)
        }
    }
  }

  private enum Constants {
    static let imageCornerRadius = 8.0
    static let imageSize = 28.0
  }
}

#Preview {
  BaseContentView {
    HStack {
      YoutubeLinkView(key: "e1k1PC0TtmE")
      YoutubeLinkView(key: "SdvzhCL7vIA")
    }
    .padding()
  }
}