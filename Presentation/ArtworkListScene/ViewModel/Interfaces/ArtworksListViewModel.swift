import Foundation
import Domain
import SwiftUI

public protocol ArtworksListViewModelDisplayLogic {
    func displayData() async
    func displayNextPage() async
}

public protocol ArtworksListViewModelInputLogic {
    func prepareData() async throws
    func goToNextPage(_ nextPage: String?) async throws
}

@MainActor
public protocol ArtworksListViewModelOutputLogic {
    var artworksList: [Artworks] { get }
    var pagination: Pagination? { get }
}

public protocol ArtworksListViewModel: ArtworksListViewModelOutputLogic, ArtworksListViewModelInputLogic, ObservableObject {}
