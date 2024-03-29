public struct ArtworksModelData: Decodable {
    public let data: [Artworks]
    public let pagination: Pagination
    
    public init(data: [Artworks], pagination: Pagination) {
        self.data = data
        self.pagination = pagination
    }
}

public struct Artworks: Identifiable, Decodable, Hashable {
    public var uuid = UUID()
    public let id: Int
    public let artistId: Int?
    public let title: String
    public let description: String?
    public let thumbnail: Thumbnail?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case artistId = "artist_id"
        case title
        case description
        case thumbnail
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.artistId = try container.decode(Int?.self, forKey: .artistId)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    public static func == (lhs: Artworks, rhs: Artworks) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public struct Thumbnail: Decodable {
    public let image: String
    public let width: CGFloat
    public let height: CGFloat
    public let subtitle: String
    
    public enum CodingKeys: String, CodingKey {
        case image = "lqip"
        case width
        case height
        case subtitle = "alt_text"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(String.self, forKey: .image)
        self.width = try container.decode(CGFloat.self, forKey: .width)
        self.height = try container.decode(CGFloat.self, forKey: .height)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
    }
}

public struct Pagination: Decodable {
    public let nextPage: String
    
    public enum CodingKeys: String, CodingKey {
        case nextPage = "next_url"
    }
    
    init(nextPage: String) {
        self.nextPage = nextPage
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage) ?? ""
    }
}
