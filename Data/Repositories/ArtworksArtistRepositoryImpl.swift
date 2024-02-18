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
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
             throw NetworkError.invalidServerResponse
        }
        
        let artworksArtistModelData = try JSONDecoder().decode(ArtworksArtistModelData.self, from: data)
        
        return artworksArtistModelData
    }
}
