import Foundation

public protocol ArtworksRepository {
    func fetchArtworksModel(_ source: String) async throws -> ArtworksModelData
}
