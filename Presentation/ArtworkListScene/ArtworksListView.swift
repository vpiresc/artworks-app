import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import Kingfisher

public struct ArtworksListView<VM: ArtworksListViewModel>: View {
    @ObservedObject public var viewModel: VM
    @State private var showingAlert = false
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.artworksList, id: \.id) { artworks in
                            Text(artworks.title)
                            Text(artworks.thumbnail.subtitle)
                            NavigationLink(destination: ArtworkDetailViewFactory.make(
                                artistId: artworks.artistId,
                                artwork: artworks
                            )) {
                                WebImage(url: URL(string: artworks.thumbnail.image))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .onAppear {
                                        let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: artworks.thumbnail.image))
                                        SDWebImageManager.shared.imageCache.store?(
                                            nil,
                                            imageData: nil,
                                            forKey: cacheKey,
                                            context: nil,
                                            cacheType: .disk
                                        )
                                    }}
                        }
                    }
                    .padding()
                    Button {
                        loadNextPage()
                    } label: {
                        Text("Load more artworks")
                    }
                }
            }.id(UUID())
                .navigationTitle("Artworks List")
                .refreshable {
                    await displayNextPage()
                }
                .task {
                    await displayData()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(Strings.error_title),
                        message: Text(Strings.error_message),
                        dismissButton: .default(Text(Strings.error_tryAgain_button), action: {
                            Task {
                                await displayData()
                            }
                        }))
                }
        }
    }
    private func loadNextPage() {
        Task {
            await displayNextPage()
        }
    }
}

extension ArtworksListView: ArtworksListViewModelDisplayLogic {
    public func displayData() async {
        do {
            try await viewModel.prepareData()
        } catch {
            showingAlert = true
            print(error)
        }
    }
    
    public func displayNextPage() async {
        do {
            try await viewModel.goToNextPage(viewModel.pagination?.nextPage)
        } catch {
            showingAlert = true
            print(error)
        }
    }
}
