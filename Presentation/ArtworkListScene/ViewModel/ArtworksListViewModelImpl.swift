import Foundation
import Domain
import SwiftUI

@MainActor
public class ArtworksListViewModelImpl {
    @Published public var artworksList: [Artworks] = []
    @Published public var pagination: Pagination?
    
    private let useCase: GetArtworksUseCase
    
    public init(useCase: GetArtworksUseCase) {
        self.useCase = useCase
    }
}

extension ArtworksListViewModelImpl: ArtworksListViewModel {
    public func prepareData() async throws {
        do {
            let artworksModelData = try await useCase.execute(with: Constants.Urls.artworksList)
            artworksList = artworksModelData.data
            pagination = artworksModelData.pagination
        } catch {
            throw(PresentationError.unableToLoad)
        }
    }
    
    public func goToNextPage(_ nextPage: String?) async throws {
        do {
            let artworksModelData = try await useCase.execute(with: nextPage ?? "")
            artworksList = artworksList + artworksModelData.data
            pagination = artworksModelData.pagination
        } catch {
            throw(PresentationError.unableToLoad)
        }
    }
}
