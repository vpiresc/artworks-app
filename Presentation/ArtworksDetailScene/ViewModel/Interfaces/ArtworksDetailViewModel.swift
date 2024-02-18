import Foundation
import Domain
import SwiftUI

public protocol ArtworksDetailViewModelDisplayLogic {
    func displayData(artistId: Int?) async
}

public protocol ArtworksDetailViewModelInputLogic {
    func prepareData(artistId: Int?) async throws
}

@MainActor
public protocol ArtworksDetailViewModelOutputLogic {
    var artworksArtist: ArtworksArtist? { get }
    var artworks: Artworks { get }
}

public protocol ArtworksDetailViewModel: ArtworksDetailViewModelOutputLogic, ArtworksDetailViewModelInputLogic, ObservableObject {}
