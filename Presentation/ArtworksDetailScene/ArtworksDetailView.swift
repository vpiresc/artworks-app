import SwiftUI

public struct ArtworksDetailView<VM: ArtworksDetailViewModel>: View {
    @ObservedObject public var viewModel: VM
    @State private var showingAlert = false
    let artistId: Int?
    
    public init(viewModel: VM, artistId: Int?) {
        self.viewModel = viewModel
        self.artistId = artistId
    }
    
    public var body: some View {
        ScrollView {
            VStack() {
                let artistName = viewModel.artworksArtist?.title ?? ""
                let artistDescription = viewModel.artworksArtist?.description
                Text(artistName)
                let artworks = viewModel.artworks
                Text(artworks.title )
                Text(artworks.thumbnail.subtitle )
                AsyncImage(url: URL(string: artworks.thumbnail.image )) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
                renderHtmlText(artistDescription)
            }
        }.id(UUID())
            .navigationTitle("Artworks Detail")
            .task {
                await displayData(artistId: artistId)
            }.alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(Strings.error_title),
                    message: Text(Strings.error_message),
                    primaryButton: .default(Text(Strings.error_tryAgain_button), action: {
                        Task {
                            await displayData(artistId: artistId)
                        }
                    }),
                    secondaryButton: .cancel(Text(Strings.error_cancel_button))
                    )
            }
    }
    
    private func renderHtmlText(_ text: String?) -> Text {
        let artistDescription = viewModel.artworksArtist?.description ?? ""
        if let nsAttributedString = try? NSAttributedString(data: Data((artistDescription.utf8)), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            return Text(attributedString).font(.body)
        } else {
            return Text(artistDescription.description)
        }
    }
}

extension ArtworksDetailView: ArtworksDetailViewModelDisplayLogic {
    public func displayData(artistId: Int?) async {
        do {
            try await viewModel.prepareData(artistId: artistId)
        } catch {
            showingAlert = true
            print(error)
        }
    }
}


public extension NSMutableAttributedString {
    @discardableResult func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        addAttributes([ NSAttributedString.Key.font: UIFontMetrics.default.scaledFont(for: font)], range: NSRange(location: 0, length: string.count))
        return self
    }
}

