import SwiftUI
import Domain
import Data

public struct ArtworkListViewFactory {
    @MainActor public static func make() -> some View {
        let repository = ArtworksRepositoryImpl()
        let useCase = GetArtworksUseCaseImpl(repository: repository)
        let viewModel = ArtworksListViewModelImpl(useCase: useCase)
        let view = ArtworksListView(viewModel: viewModel)
        return view
    }
    
    public init() {}
}

public struct ArtworkDetailViewFactory {
    @MainActor public static func make(artistId: Int, artwork: Artworks) -> some View {
        let repository = ArtworksArtistRepositoryImpl()
        let useCase = GetArtworksArtistUseCaseImpl(repository: repository)
        let viewModel = ArtworksDetailViewModelImpl(useCase: useCase, artworks: artwork)
        let view = ArtworksDetailView(viewModel: viewModel, artistId: artistId)
        return view
    }
}

public struct AlertFactory {
    public static func  make(
        title: String = Strings.error_generic_title,
        primaryButton: String = Strings.error_button) -> Alert {
            return  Alert(
                title: Text(title),
                dismissButton: .default(Text(primaryButton))
            )
        }
}
