import Foundation
import Domain
import SwiftUI

@MainActor
public class ArtworksDetailViewModelImpl {
    @Published public var artworksArtist: ArtworksArtist?
    @Published public var artworks: Artworks
    
    private let useCase: GetArtworksArtistUseCase
    
    public init(useCase: GetArtworksArtistUseCase, artworks: Artworks) {
        self.useCase = useCase
        self.artworks = artworks
    }
}

extension ArtworksDetailViewModelImpl: ArtworksDetailViewModel {
    public func prepareData(artistId: Int?) async throws {
        do {
            let artworksArtistModelData = try await useCase.execute(with: artistId)
            artworksArtist = artworksArtistModelData.data
        } catch {
            throw(PresentationError.unableToLoad)
        }
    }
}
