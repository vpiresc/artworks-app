import Foundation

public protocol GetArtworksArtistUseCase {
    func execute(with artistId: Int) async throws -> ArtworksArtistModelData
}
