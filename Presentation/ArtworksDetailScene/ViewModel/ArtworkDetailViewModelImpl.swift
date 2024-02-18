import Foundation
import Domain
import SwiftUI

@MainActor
public class ArtworksDetailViewModelImpl {
    @Published public var artworksArtist: ArtworksArtist?
    @Published public var artworks: Artworks
    @Published public var alertMessage = ""
    public var showAlert = false
    private let useCase: GetArtworksArtistUseCase
    
    public init(useCase: GetArtworksArtistUseCase, artworks: Artworks) {
        self.useCase = useCase
        self.artworks = artworks
    }
}

extension ArtworksDetailViewModelImpl: ArtworksDetailViewModel {
    public func prepareData(artistId: Int) async throws {
        do {
            let artworksArtistModelData = try await useCase.execute(with: artistId)
            artworksArtist = artworksArtistModelData.data
        } catch NetworkError.unableToFetch {
            alertMessage = Strings.error_missing_title
            showAlert = true
        } catch {
            alertMessage = Strings.error_generic_title
            showAlert = true
        }
    }
    
    public func showAlertMessage() -> String { return alertMessage }
    
    public func shouldShowAlert() -> Bool { showAlert }
}
