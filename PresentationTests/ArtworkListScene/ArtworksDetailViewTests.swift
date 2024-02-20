import XCTest
import Presentation
import Domain
import Data

@MainActor
final class ArtworksDetailViewTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var repositoryMock: ArtworksArtistRepository!
    var useCaseMock: GetArtworksArtistUseCaseMock!
    var viewModelSpy: ArtworksDetailViewModelSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        repositoryMock = ArtworksArtistRepositoryMock()
        useCaseMock = GetArtworksArtistUseCaseMock()
        viewModelSpy = ArtworksDetailViewModelSpy()
    }
    
    override func tearDown() {
        repositoryMock = nil
        useCaseMock = nil
        viewModelSpy = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_displayData_shouldCallPrepareDataAndAlerts() async {
        let sut = ArtworksDetailView(viewModel: viewModelSpy, artistId: 1)
        
        _ = await sut.displayData(artistId: 1)
        
        XCTAssertEqual(viewModelSpy.prepareDataWasCalled, 1)
        XCTAssertEqual(viewModelSpy.showAlertMessageWasCalled, 1)
        XCTAssertEqual(viewModelSpy.shouldShowAlertWasCalled, 1)
    }
}
