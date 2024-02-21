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
    
    func test_execute_withSuccessAndValidResponse_shouldReturnArtworksModel() async {
        repositoryMock.responseType = .success
        repositoryMock.jsonResponse = Stubs.makefetchArtworksModelStub()
        
        do {
            let artworksModel = try await sut.execute(with: "")
            XCTAssertNotNil(artworksModel.data)
            XCTAssertNotNil(artworksModel.pagination)
        } catch {
            fatalError("execute should not return any error")
        }
    }

func test_execute_withSuccessAndInvalidResponse_shouldReturnAnError() async {
    repositoryMock.responseType = .success
    repositoryMock.jsonResponse = ""
    
    do {
        _ = try await sut.execute(with: "")
        XCTFail("execute should not return any response")
    } catch {
        XCTAssertNotNil(error)
    }
}
    
    func test_execute_withFailureAndInvalidResponse_shouldReturnAnError() async {
        repositoryMock.responseType = .failure
        repositoryMock.jsonResponse = ""
        
        do {
            _ = try await sut.execute(with: "")
            XCTFail("execute should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_execute_withFailureAndValidResponse_shouldReturnAnError() async {
        repositoryMock.responseType = .failure
        repositoryMock.jsonResponse = Stubs.makefetchArtworksModelStub()
        
        do {
            _ = try await sut.execute(with: "")
            XCTFail("execute should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_execute_withNoConnectivityFalse_shouldNotHaveCheckInternetConnection() async {
        repositoryMock.responseType = .success
        repositoryMock.jsonResponse = Stubs.makefetchArtworksModelStub()
        repositoryMock.isConnected = false
        do {
            _ = try await sut.execute(with: "")
            XCTAssertFalse(repositoryMock.checkInternetConnection())
        } catch {
            fatalError("execute should not return any error")
        }
    }
    
    func test_execute_withNoConnectivityTrue_shouldHaveCheckInternetConnection() async {
        repositoryMock.responseType = .success
        repositoryMock.jsonResponse = Stubs.makefetchArtworksModelStub()
        repositoryMock.isConnected = true
        do {
            _ = try await sut.execute(with: "")
            XCTAssertTrue(repositoryMock.checkInternetConnection())
        } catch {
            fatalError("execute should not return any error")
        }
    }
}
