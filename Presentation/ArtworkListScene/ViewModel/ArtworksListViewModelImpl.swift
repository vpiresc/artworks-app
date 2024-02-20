import Foundation
import Domain
import SwiftUI

@MainActor
public class ArtworksListViewModelImpl {
    @Published public var artworksList: [Artworks] = []
    @Published public var pagination: Pagination?
    @Published public var alertMessage = ""
    @Published public var showAlert = false
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
        } catch NetworkError.unableToFetch {
            alertMessage = Strings.error_missing_title
            showAlert = true
        } catch NetworkError.noConnectivity{
            alertMessage = Strings.error_noConnectivity_title
            showAlert = true
        } catch {
            alertMessage = Strings.error_generic_title
            showAlert = true
        }
    }
    
    public func goToNextPage(_ nextPage: String?) async throws {
        showAlert = false
        do {
            let artworksModelData = try await useCase.execute(with: nextPage ?? "")
            artworksList = artworksList + artworksModelData.data
            pagination = artworksModelData.pagination
        } catch NetworkError.unableToFetch {
            alertMessage = Strings.error_missing_title
            showAlert = true
        } catch NetworkError.noConnectivity{
            alertMessage = Strings.error_noConnectivity_title
            showAlert = true
        } catch {
            alertMessage = Strings.error_generic_title
            showAlert = true
        }
    }
    
    public func showAlertMessage() -> String { return alertMessage }
    
    public func shouldShowAlert() -> Bool { showAlert }
}
