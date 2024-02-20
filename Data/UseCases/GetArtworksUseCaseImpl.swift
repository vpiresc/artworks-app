import Foundation

public final class GetArtworksUseCaseImpl: GetArtworksUseCase {
    let repository: ArtworksRepository
    
    public init(repository: ArtworksRepository) {
        self.repository = repository
    }
    
    public func execute(with url: String) async throws -> ArtworksModelData {
        do {
            let result = try await repository.fetchArtworksModel(url)
            return result
        } catch {
            throw(error)
        }
    }
}
