import Foundation
import Domain

final class ArtworksRepositoryMock: ArtworksRepository {
    var jsonResponse: String
    var responseType: ResponseType
    var error: Error = ResponseErrorMock.failedFetching
    var isConnected = false
    
    init(jsonResponse: String = "", responseType: ResponseType = .success) {
        self.jsonResponse = jsonResponse
        self.responseType = responseType
    }
    
    func fetchArtworksModel(_ source: String) async throws -> ArtworksModelData {
        switch responseType {
        case .success:
            guard let data = jsonResponse.data(using: .utf8) else {
                throw error
            }
            do {
                let artworksModel = try JSONDecoder().decode(ArtworksModelData.self, from: data)
                return artworksModel
            } catch {
                throw error
            }
        case .failure:
            throw error
            
        }
    }
    
    func checkInternetConnection() -> Bool {
        return isConnected
    }
}
