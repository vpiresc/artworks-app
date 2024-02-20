import Domain
import Presentation

final class ArtworksDetailViewModelSpy: ArtworksDetailViewModel {
    var showAlertMessageWasCalled = 0
    var shouldShowAlertWasCalled = 0
    var prepareDataWasCalled = 0
    var artworksArtist: ArtworksArtist?
    var artworks = try! JSONDecoder().decode(Artworks.self, from: Stubs.makeArtworksStub().data(using: .utf8)!)
    
    func showAlertMessage() -> String {
        showAlertMessageWasCalled += 1
        return ""
    }
    
    func shouldShowAlert() -> Bool {
        shouldShowAlertWasCalled += 1
        return true
    }
    
    func prepareData(artistId: Int) async throws {
        prepareDataWasCalled += 1
    }
    
   
    
    
    
}
