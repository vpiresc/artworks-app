import Domain

public final class ArtworksArtistRepositoryImpl {
    let session: URLSession
    let networkMonitor: NetworkMonitor
    
    public init(session: URLSession = .shared, networkMonitor: NetworkMonitor = .init()) {
        self.session = session
        self.networkMonitor = networkMonitor
    }
}

extension ArtworksArtistRepositoryImpl: ArtworksArtistRepository {
    public func fetchArtworksArtistModel(_ url: String) async throws -> ArtworksArtistModelData {
        if !checkInternetConnection() {
            throw NetworkError.noConnectivity
        }
        
        guard let url = URL(string: url) else {
            throw NetworkError.invalidUrl
        }
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 400...499:
                throw NetworkError.badRequest
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.invalidServerResponse
            }
        }
        
        let artworksArtistModelData = try JSONDecoder().decode(ArtworksArtistModelData.self, from: data)
        
        return artworksArtistModelData
    }
    
    public func checkInternetConnection() -> Bool {
        networkMonitor.isConnected
    }
}
