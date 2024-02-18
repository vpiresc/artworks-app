import Foundation

public final class GetArtworksArtistUseCaseImpl: GetArtworksArtistUseCase {
    let repository: ArtworksArtistRepository
    
    public init(repository: ArtworksArtistRepository) {
        self.repository = repository
    }
    
    public func execute(with artistId: Int?) async throws -> ArtworksArtistModelData {
        do {
            return try await repository.fetchArtworksArtistModel(Constants.Urls.artworksDetail(artistId: artistId ?? nil))
        } catch {
            throw(NetworkError.unableToFetch)
        }
    }
}
