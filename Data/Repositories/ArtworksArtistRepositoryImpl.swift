import Domain

public final class ArtworksArtistRepositoryImpl {
    let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ArtworksArtistRepositoryImpl: ArtworksArtistRepository {    
    public func fetchArtworksArtistModel(_ url: String) async throws -> ArtworksArtistModelData {
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
}
