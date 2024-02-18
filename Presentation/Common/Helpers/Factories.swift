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
    public static func  make(action: @escaping  () -> Void) -> Alert {
        return  Alert(
            title: Text(Strings.error_title),
            message: Text(Strings.error_message),
            primaryButton: .default(Text(Strings.error_tryAgain_button), action: {
                action()
            }),
            secondaryButton: .cancel(Text(Strings.error_cancel_button))
        )
    }
}


