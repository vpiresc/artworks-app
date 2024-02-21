import SwiftUI

private enum ArtworksDetailViewMargins {
    static let webImageSize: CGFloat = 300
}

public struct ArtworksDetailView<VM: ArtworksDetailViewModel>: View {
    @ObservedObject public var viewModel: VM
    @State private var showingAlert = false
    @State private var alertMessage = ""
    private typealias Margins = ArtworksDetailViewMargins
    private let artistId: Int
    
    public init(viewModel: VM, artistId: Int) {
        self.viewModel = viewModel
        self.artistId = artistId
    }
    
    public var body: some View {
        ScrollView {
            VStack() {
                let artworks = viewModel.artworks
                let artworksImage = artworks.thumbnail?.image ?? ""
                Text(artworks.title).fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text(viewModel.artworksArtist?.title ?? Strings.artworks_artist_placeholder)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)

                Text(artworks.thumbnail?.subtitle ?? "")
                    .multilineTextAlignment(.leading)
                    .padding()
                AsyncImage(url: URL(string: artworksImage)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Margins.webImageSize, height: Margins.webImageSize)
                } placeholder: {
                    ProgressView()
                }
                let description = artworks.description?.removingHTMLTags()
                Text(description ?? "")
                    .italic()
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .padding()
                }
        }.id(UUID())
            .navigationTitle(Strings.artworks_detail_screen_title)
            .padding()
            .task {
                await displayData(artistId: artistId)
            }.alert(isPresented: $showingAlert) {
                AlertFactory.make(title: alertMessage)
            }
    }
}

extension ArtworksDetailView: ArtworksDetailViewModelDisplayLogic {
    public func displayData(artistId: Int) async {
        do {
            try await viewModel.prepareData(artistId: artistId)
            displayAlert()
        } catch {
            showingAlert = true
        }
    }
    
    public func displayAlert() {
        alertMessage = viewModel.showAlertMessage()
        showingAlert = viewModel.shouldShowAlert()
    }
}
