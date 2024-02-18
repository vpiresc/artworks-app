import Foundation
import Domain
import SwiftUI

public protocol ArtworksDetailViewModelDisplayLogic {
    func displayData(artistId: Int) async
    func displayAlert()
}

public protocol ArtworksDetailViewModelInputLogic {
    func prepareData(artistId: Int) async throws
}

@MainActor
public protocol ArtworksDetailViewModelOutputLogic {
    var artworksArtist: ArtworksArtist? { get }
    var artworks: Artworks { get }
    func showAlertMessage() -> String
    func shouldShowAlert() -> Bool
}

public protocol ArtworksDetailViewModel: ArtworksDetailViewModelOutputLogic, ArtworksDetailViewModelInputLogic, ObservableObject {}
