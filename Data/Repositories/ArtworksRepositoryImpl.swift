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
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
             throw NetworkError.invalidServerResponse
        }
        
        let artworksModelData = try JSONDecoder().decode(ArtworksModelData.self, from: data)
        
        return artworksModelData
    }
}
