import Foundation
import Domain

final class ArtworksArtistRepositoryMock: ArtworksArtistRepository {
    var jsonResponse: String
    var responseType: ResponseType
    var error: Error = ResponseErrorMock.failedFetching
    
    init(jsonResponse: String = "", responseType: ResponseType = .success) {
        self.jsonResponse = jsonResponse
        self.responseType = responseType
    }
    
    func fetchArtworksArtistModel(_ source: String) async throws -> ArtworksArtistModelData {
        switch responseType {
        case .success:
            guard let data = jsonResponse.data(using: .utf8) else {
                throw error
            }
            do {
                let artworksArtistModel = try JSONDecoder().decode(ArtworksArtistModelData.self, from: data)
                return artworksArtistModel
            } catch {
                throw error
            }
        case .failure:
            throw error
            
        }
    }
}
