import SwiftUI
import SDWebImageSwiftUI

private enum ArtworkListViewMargins {
    static let vStackSpacing: CGFloat = 16
    static let cornerRadius: CGFloat = 8
    static let cardShadow: CGFloat = 2
    static let smallPadding: CGFloat = 4
    static let padding: CGFloat = 8
    static let cardHeight: CGFloat = 140
    static let webImageSize: CGFloat = 80
    static let subtitlePrefix: Int = 120
    static let titlePrefix: Int = 40
    static let opacity: CGFloat = 0.5
}

public struct ArtworksListView<VM: ArtworksListViewModel>: View {
    @ObservedObject public var viewModel: VM
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var scrollToArtworks: Int?
    private typealias Margins = ArtworkListViewMargins
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: Margins.vStackSpacing) {
                        ForEach(viewModel.artworksList, id: \.id) { artworks in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: Margins.cornerRadius)
                                    .fill(.white)
                                    .shadow(radius: Margins.cardShadow)
                                    .padding(Margins.smallPadding)
                                    .frame(height: Margins.cardHeight)
                                NavigationLink(destination: ArtworkDetailViewFactory.make(
                                    artistId: artworks.artistId ?? 0,
                                    artwork: artworks
                                )) {
                                    WebImage(url: URL(string: artworks.thumbnail.image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Margins.webImageSize, height: Margins.webImageSize)
                                        .onAppear {
                                            Helpers.cacheImage(with: artworks.thumbnail.image)
                                        }
                                    VStack(alignment: .leading) {
                                        Text(artworks.title.prefix(Margins.titlePrefix)+"...")
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                        Text(artworks.thumbnail.subtitle.prefix(Margins.subtitlePrefix)+"...")
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.leading)
                                    }
                                }.padding(.horizontal, Margins.padding)
                            }.id(UUID())
                                .ignoresSafeArea()
                        }
                    }.scrollTargetLayout()
                    Button {
                        loadNextPage()
                    } label: {
                        HStack {
                            Image(systemName: Strings.load_more_image)
                            Text(Strings.load_more_button)
                        }
                    }.buttonBorderShape(.roundedRectangle)
                        .padding()
                        .tint(.black).opacity(Margins.opacity)
                        .cornerRadius(Margins.cornerRadius)
                        .buttonStyle(.bordered)
                    
                }.scrollTargetBehavior(.paging)
                    .onAppear {
                        withAnimation(.smooth) {
                            guard let lastArtworksList = viewModel.artworksList.last else { return }
                            scrollToArtworks = lastArtworksList.id
                            if let scrollToArtworks = scrollToArtworks {
                                proxy.scrollTo(scrollToArtworks, anchor: .bottom)
                            }
                        }
                    }
            }.padding()
        }.id(UUID())
            .navigationTitle(Strings.artworks_list_screen_title)
            .refreshable {
                if networkMonitor.isConnected {
                    await displayData()
                } else {
                    displayNoConnectionAlert()
                }
            }
            .task {
                if networkMonitor.isConnected {
                    await displayData()
                } else {
                    displayNoConnectionAlert()
                }
            }
            .alert(isPresented: $showingAlert) {
                AlertFactory.make(title: alertMessage)
            }
    }
    
    private func loadNextPage() {
        if networkMonitor.isConnected {
            Task {
                await displayNextPage()
            }
        } else {
                displayNoConnectionAlert()
            }
        
    }
}

extension ArtworksListView: ArtworksListViewModelDisplayLogic {
    public func displayNoConnectionAlert() {
        alertMessage = Strings.error_noConnectivity_title
        showingAlert = true
    }
    
    public func displayData() async {
        do {
            try await viewModel.prepareData()
            displayAlert()
        } catch {
            showingAlert = true
        }
    }
    
    public func displayNextPage() async{
        do {
            try await viewModel.goToNextPage(viewModel.pagination?.nextPage)
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
