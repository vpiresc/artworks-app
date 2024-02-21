import XCTest
import Data
import Domain

final class ArtworksRepositoryImplTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ArtworksRepository!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.default
        config.protocolClasses = [UrlProtocolMock.self]
        let session = URLSession(configuration: config)
        sut = ArtworksRepositoryImpl(session: session)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_fetchArtworksModelWithValidData_shouldReturnArtworksModelResponse() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(),
            error: nil
        )
        
        do {
            let artworksModelResponse = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
                XCTAssertNotNil(artworksModelResponse)
        } catch {
            fatalError("fetchArtworksModel should not return any error")
        }
    }
    
    func test_fetchArtworksModelWithInValidData_shouldReturnError() async {
        UrlProtocolMock.simulate(
            data: Stubs.makeInvalidData(),
            response: Stubs.makeHttpResponse(),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_fetchArtworksModelWith400_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 400),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.badRequest.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWith401_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 401),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.unauthorized.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWith403_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 403),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.forbidden.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWith500_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 500),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.serverError.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWithUnknow_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 0),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidServerResponse.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWithInvalidUrl_shouldReturnNetworkError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 200),
            error: nil
        )
        
        do {
            _ = try await sut.fetchArtworksModel("")
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, NetworkError.invalidUrl.localizedDescription)
        }
    }
    
    func test_fetchArtworksModelWithAnyError_shouldReturnAnyError() async {
        UrlProtocolMock.simulate(
            data: Data(Stubs.makefetchArtworksModelStub().utf8),
            response: Stubs.makeHttpResponse(statusCode: 200),
            error: Stubs.makeError()
        )
        
        do {
            _ = try await sut.fetchArtworksModel(Stubs.makeUrl().absoluteString)
            fatalError("fetchArtworksModel should not return any response")
        } catch {
            XCTAssertEqual(error.localizedDescription, Stubs.makeError().localizedDescription)
        }
    }
}
