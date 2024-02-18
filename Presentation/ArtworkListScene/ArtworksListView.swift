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
    static let opacity: CGFloat = 0.5
}

public struct ArtworksListView<VM: ArtworksListViewModel>: View {
    @ObservedObject public var viewModel: VM
    @State private var showingAlert = false
    private typealias Margins = ArtworkListViewMargins
    @State private var alertMessage = ""
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
//            ScrollViewReader { proxy in
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
                                            let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: artworks.thumbnail.image))
                                            SDWebImageManager.shared.imageCache.store?(
                                                nil,
                                                imageData: nil,
                                                forKey: cacheKey,
                                                context: nil,
                                                cacheType: .disk
                                            )
                                        }
                                    VStack(alignment: .leading) {
                                        Text(artworks.title)
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
                    }
                    Button {
                        loadNextPage()
//                        proxy.scrollTo(viewModel.artworksList.last?.uuid, anchor: .bottom)
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
                }
                
            }
            .padding()
//        }.scrollTargetLayout()
            .id(UUID())
            .navigationTitle(Strings.artworks_list_screen_title)
            .refreshable {
                await displayNextPage()
            }
            .task {
                await displayData()
            }
            .alert(isPresented: $showingAlert) {
                AlertFactory.make(title: alertMessage)
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
