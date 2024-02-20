import XCTest
import Presentation
import Domain
import Data

final class ArtworksListViewModelImplTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ArtworksListViewModelImpl!
    var repositoryMock: ArtworksRepository!
    var useCaseMock: GetArtworksUseCaseMock!
    
    // MARK: - Test lifecycle
    
    @MainActor override func setUp() {
        super.setUp()
        repositoryMock = ArtworksRepositoryMock()
        useCaseMock = GetArtworksUseCaseMock()
        sut = ArtworksListViewModelImpl(useCase: useCaseMock)
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
           _ = try await sut.prepareData()
            XCTAssertEqual(useCaseMock.executeWasCalled, 1)
            XCTAssertNotNil(useCaseMock.pagination)
        } catch {
            fatalError("prepareData should not return any error")
        }
    }
}
