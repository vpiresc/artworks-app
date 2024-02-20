import Domain
import Data
@testable import ArtworksApp
final class GetArtworksArtistUseCaseMock: GetArtworksArtistUseCase {
    var executeWasCalled = 0
    
    func execute(with artistId: Int) async throws -> ArtworksArtistModelData {
        executeWasCalled += 1
        return ArtworksArtistModelData(data: ArtworksArtist(id: 1, title: "title"))
    }
}
