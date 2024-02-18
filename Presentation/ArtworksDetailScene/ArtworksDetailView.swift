import SwiftUI
import SDWebImageSwiftUI

private enum ArtworksDetailViewMargins {
    static let webImageSize: CGFloat = 400
}

public struct ArtworksDetailView<VM: ArtworksDetailViewModel>: View {
    @ObservedObject public var viewModel: VM
    @State private var showingAlert = false
    private typealias Margins = ArtworksDetailViewMargins
    let artistId: Int
    
    public init(viewModel: VM, artistId: Int) {
        self.viewModel = viewModel
        self.artistId = artistId
    }
    
    public var body: some View {
        ScrollView {
            VStack() {
                let artistDescription = viewModel.artworksArtist?.description ?? ""
                let artworks = viewModel.artworks
                Text(viewModel.artworksArtist?.title ?? "Not available")
                Text(artworks.title)
                Text(artworks.thumbnail.subtitle )
//                AsyncImage(url: URL(string: artworks.thumbnail.image )) { image in
//                    image.resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: Margins.webImageSize, height: Margins.webImageSize)
//                } placeholder: {
//                    ProgressView()
//                }
                    WebImage(url: URL(string: artworks.thumbnail.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Margins.webImageSize, height: Margins.webImageSize)
                        .onAppear {
                            let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: artworks.thumbnail.image))
                            SDWebImageManager.shared.imageCache.store?(
                                nil,
                                imageData: nil,
                                forKey: cacheKey,
                                context: nil,
                                cacheType: .disk
                            )
                        }
                renderHtmlText(artistDescription)
                }
        }.id(UUID())
            .navigationTitle(Strings.artworks_detail_screen_title)
            .task {
                await displayData(artistId: artistId)
            }.alert(isPresented: $showingAlert) {
                AlertFactory.make(action: {
                    Task {
                        await displayData(artistId: artistId)
                    }
                })
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
    public func displayData(artistId: Int) async {
        do {
            try await viewModel.prepareData(artistId: artistId)
        } catch {
            showingAlert = true
            print(error)
        }
    }
}

