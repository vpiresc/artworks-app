import XCTest
import Presentation

@MainActor
final class ArtworksListViewTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var repositoryMock: ArtworksRepositoryMock!
    var useCaseMock: GetArtworksUseCaseMock!
    var viewModelSpy: ArtworksListViewModelSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        repositoryMock = ArtworksRepositoryMock()
        useCaseMock = GetArtworksUseCaseMock()
        viewModelSpy = ArtworksListViewModelSpy()
    }
    
    override func tearDown() {
        repositoryMock = nil
        useCaseMock = nil
        viewModelSpy = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_displayData_shouldCallPrepareData() async {
        let sut = ArtworksListView(viewModel: viewModelSpy)
        
        _ = await sut.displayData()
        
        XCTAssertEqual(viewModelSpy.prepareDataWasCalled, 1)
        XCTAssertEqual(viewModelSpy.showAlertMessageWasCalled, 1)
        XCTAssertEqual(viewModelSpy.shouldShowAlertWasCalled, 1)
    }
    
    func test_displayNextPage_shouldCallPrepareData() async {
        let sut = ArtworksListView(viewModel: viewModelSpy)
        
        _ = await sut.displayNextPage()
        
        XCTAssertEqual(viewModelSpy.goToNextPageWasCalled, 1)
        XCTAssertEqual(viewModelSpy.showAlertMessageWasCalled, 1)
        XCTAssertEqual(viewModelSpy.shouldShowAlertWasCalled, 1)
    }
}
