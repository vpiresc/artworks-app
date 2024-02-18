public struct ArtworksArtistModelData: Decodable {
    public let data: ArtworksArtist
    
    public init(data: ArtworksArtist) {
        self.data = data
    }
}

public struct ArtworksArtist: Decodable {
    public let id: Int
    public let title: String?
    public let description: String?
    
    public init(id: Int, title: String?, description: String?) {
        self.id = id
        self.title = title
        self.description = description

    }
}
