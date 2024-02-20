import XCTest
import Presentation
import Domain
import Data

final class ArtworksDetailViewModelImplTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ArtworksDetailViewModelImpl!
    var repositoryMock: ArtworksArtistRepository!
    var useCaseMock: GetArtworksArtistUseCaseMock!
    var artworks: Artworks?
    
    // MARK: - Test lifecycle
    
    @MainActor override func setUp() {
        super.setUp()
        artworks = try! JSONDecoder().decode(Artworks.self, from: Stubs.makeArtworksStub().data(using: .utf8)!)
        repositoryMock = ArtworksArtistRepositoryMock()
        useCaseMock = GetArtworksArtistUseCaseMock()
        sut = ArtworksDetailViewModelImpl(useCase: useCaseMock, artworks: artworks!)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        useCaseMock = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_prepareData_shouldCallUseCaseExecute() async {
        do {
            _ = try await sut.prepareData(artistId: 1)
            XCTAssertEqual(useCaseMock.executeWasCalled, 1)
        } catch {
            fatalError("prepareData should not return any error")
        }
    }
}
