import Domain
import Presentation

final class ArtworksListViewModelSpy: ArtworksListViewModel {
    var artworksList: [Artworks] = []
    var pagination: Pagination?
    var showAlertMessageWasCalled = 0
    var shouldShowAlertWasCalled = 0
    var prepareDataWasCalled = 0
    var goToNextPageWasCalled = 0
    
    func showAlertMessage() -> String {
        showAlertMessageWasCalled += 1
        return ""
    }
    
    func shouldShowAlert() -> Bool {
        shouldShowAlertWasCalled += 1
        return true
    }
    
    func prepareData() async throws {
        prepareDataWasCalled += 1
    }
    
    func goToNextPage(_ nextPage: String?) async throws {
        goToNextPageWasCalled += 1
    }
    
    
}
