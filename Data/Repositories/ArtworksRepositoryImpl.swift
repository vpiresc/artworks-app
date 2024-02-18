import Domain

public final class ArtworksRepositoryImpl {
    let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

extension ArtworksRepositoryImpl: ArtworksRepository {
    public func fetchArtworksModel(_ url: String) async throws -> ArtworksModelData {
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
        
        let artworksModelData = try JSONDecoder().decode(ArtworksModelData.self, from: data)
        
        return artworksModelData
    }
}
