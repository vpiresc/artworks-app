import Domain
import Data
@testable import ArtworksApp
final class GetArtworksArtistUseCaseMock: GetArtworksArtistUseCase {
    var executeWasCalled = 0
    var artworksArtistModelData = ArtworksArtistModelData(data: ArtworksArtist(id: 1, title: "title"))
    
    func execute(with artistId: Int) async throws -> ArtworksArtistModelData {
        executeWasCalled += 1
        return artworksArtistModelData
    }
}
