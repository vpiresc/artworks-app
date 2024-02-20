import SDWebImageSwiftUI

public struct Helpers {
   public static func cacheImage(with image: String) {
        let cacheKey = SDWebImageManager.shared.cacheKey(for: URL(string: image))
        SDWebImageManager.shared.imageCache.store?(
            nil,
            imageData: nil,
            forKey: cacheKey,
            context: nil,
            cacheType: .disk
        )
    }
}
