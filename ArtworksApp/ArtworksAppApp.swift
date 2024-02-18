import SwiftUI
import Presentation

@main
struct ArtworksAppApp: App {
    var body: some Scene {
        WindowGroup {
            ArtworkListViewFactory.make()
        }
    }
}
