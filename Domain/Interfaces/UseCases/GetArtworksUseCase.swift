import Foundation

public protocol GetArtworksUseCase {
    func execute(with url: String) async throws -> ArtworksModelData
}
