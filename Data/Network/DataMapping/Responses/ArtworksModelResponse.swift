public struct ArtworksModelResponse: Decodable {
    public let data: [ArtWorks]
}

public struct ArtWorks: Decodable {
    public let id: Int
    public let title: String
    
    private enum CodingKeys: CodingKey {
        case id
        case title
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
    }
}
