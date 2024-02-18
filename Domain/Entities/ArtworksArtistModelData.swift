public struct ArtworksArtistModelData: Decodable {
    public let data: ArtworksArtist
    
    public init(data: ArtworksArtist) {
        self.data = data
    }
}

public struct ArtworksArtist: Decodable {
    public let id: Int
    public let title: String
    public let description: String?
    public let artworks: Artworks
   
    
    public init(id: Int, title: String, description: String?, artworks: Artworks) {
        self.id = id
        self.title = title
        self.description = description
        self.artworks = artworks
    }
}
