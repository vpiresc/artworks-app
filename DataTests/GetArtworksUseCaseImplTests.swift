import XCTest
import Domain

final class GetArtworksUseCaseImplTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: GetArtworksUseCase!
    var repositoryMock: ArtworksRepositoryMock!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        repositoryMock = ArtworksRepositoryMock()
        sut = GetArtworksUseCaseImpl(repository: repositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_fetchArtworksListModel_withSuccessAndValidResponse_shouldReturnArtworksModelWithOneComponent() async {
        repositoryMock.responseType = .success
        repositoryMock.jsonResponse = Stubs.makefetchArtworksnModelStub()
        
        do {
            let artworksModel = try await sut.execute(with: "")
            XCTAssertNotNil(artworksModel)
        } catch {
            fatalError("execute should not return any error")
        }
    }
}
