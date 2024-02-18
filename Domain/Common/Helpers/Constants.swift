import Foundation

public struct Constants {
    public struct Urls {
        public static let baseUrl = "https://api.artic.edu/api/v1"
        public static let artworksList = "\(baseUrl)/artworks?limit=3"
        public static func artworksDetail(artistId: Int? = nil) -> String {
            return "\(baseUrl)/artists/\(artistId)"
        }
    }
}
