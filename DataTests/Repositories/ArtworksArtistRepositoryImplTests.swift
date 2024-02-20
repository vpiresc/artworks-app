import XCTest
import Data
import Domain

final class ArtworksArtistRepositoryImplTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ArtworksArtistRepository!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.default
        config.protocolClasses = [UrlProtocolMock.self]
        let session = URLSession(configuration: config)
        sut = ArtworksArtistRepositoryImpl(session: session)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_fetchArtworksArtistModelWithValidData_shouldReturnArtworksModelResponse() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(),
            error: nil
        )
        
        do {
            let artworksArtistModelResponse = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
                XCTAssertNotNil(artworksArtistModelResponse)
        } catch {
            fatalError("fetchScreenModel should not return any error")
        }
    }
    
    func test_fetchArtworksArtistModelWithInValidData_shouldReturnError() async {
        UrlProtocolMock.simulate(
            data: Stubs.makeInvalidData(),
            response: Stubs.makeHttpResponse(),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchArtworksArtistModelWith400_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 400),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.badRequest.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWith401_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 401),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.unauthorized.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWith403_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 403),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.forbidden.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWith500_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 500),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.serverError.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWithUnknow_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 0),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidServerResponse.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWithInvalidUrl_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 200),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel("")
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidUrl.localizedDescription)
        }
    }
    
    func test_fetchArtworksArtistModelWithAnyError_shouldReturnAnyError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksArtistModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 200),
            error: Stubs.makeError()
        )
        
        do {
            _ = try await sut.fetchArtworksArtistModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchScreenModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, Stubs.makeError().localizedDescription)
        }
    }
}
