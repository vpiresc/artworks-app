import XCTest
import Domain

final class GetArtworksArtistUseCaseImplTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: GetArtworksArtistUseCase!
    var repositoryMock: ArtworksArtistRepositoryMock!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        repositoryMock = ArtworksArtistRepositoryMock()
        sut = GetArtworksArtistUseCaseImpl(repository: repositoryMock)
    }
    
    override func tearDown() {
        sut = nil
        repositoryMock = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_fetchArtworksArtistModel_withSuccessAndValidResponse_shouldReturnArtworksArtistModel() async {
        repositoryMock.responseType = .success
        repositoryMock.jsonResponse = Stubs.makefetchArtworksArtistModelStub()
        
        do {
            let artworksModel = try await sut.execute(with: 1)
            XCTAssertNotNil(artworksModel.data)
        } catch {
            fatalError("execute should not return any error")
        }
    }

func test_fetchArtworksListModel_withSuccessAndInvalidResponse_shouldReturnAnError() async {
    repositoryMock.responseType = .success
    repositoryMock.jsonResponse = ""
    
    do {
        _ = try await sut.execute(with: 1)
        XCTFail("execute should not return any response")
    } catch {
        XCTAssertNotNil(error)
    }
}
    
    func test_fetchArtworksListModel_withFailureAndInvalidResponse_shouldReturnAnError() async {
        repositoryMock.responseType = .failure
        repositoryMock.jsonResponse = ""
        
        do {
            _ = try await sut.execute(with: 1)
            XCTFail("execute should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchArtworksListModel_withFailureAndValidResponse_shouldReturnAnError() async {
        repositoryMock.responseType = .failure
        repositoryMock.jsonResponse = Stubs.makefetchArtworksArtistModelStub()
        
        do {
            _ = try await sut.execute(with: 1)
            XCTFail("execute should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
