import Domain
import Data
@testable import ArtworksApp
final class GetArtworksUseCaseMock: GetArtworksUseCase {
    var executeWasCalled = 0
    let pagination: Pagination?
    let artworksModelData: ArtworksModelData?
    init() {
        pagination = try! JSONDecoder().decode(Pagination.self, from: Stubs.makePaginationStub().data(using: .utf8)!)
        artworksModelData = ArtworksModelData(data: [], pagination: pagination!)
    }
    
    func execute(with url: String) async throws -> ArtworksModelData {
        executeWasCalled += 1
        return artworksModelData!
    }
}
