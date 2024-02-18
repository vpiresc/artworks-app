import Foundation
import Domain

enum ResponseType {
    case success
    case failure
}

enum ResponseErrorMock: Error {
    case failedFetching
}

final class ArtworksRepositoryMock: ArtworksRepository {
    
    var jsonResponse: String
    var responseType: ResponseType
    var error: Error = ResponseErrorMock.failedFetching
    
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
                let screenModel = try JSONDecoder().decode(ArtworksModelData.self, from: data)
                return screenModel
            } catch {
                throw error
            }
        case .failure:
            throw error
            
        }
    }
}
