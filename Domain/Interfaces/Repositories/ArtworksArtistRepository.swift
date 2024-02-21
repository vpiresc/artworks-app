import Foundation

public protocol ArtworksArtistRepository {
    func fetchArtworksArtistModel(_ source: String) async throws -> ArtworksArtistModelData
    func checkInternetConnection() -> Bool 
}
