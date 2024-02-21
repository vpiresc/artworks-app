# About the Artworks App
The Artworks App is a simple application that displays a list of artworks from the [Art Institute of Chicago API](https://api.artic.edu/docs/) along with some detailed information about each artwork.

## Technical Details
The project is organized into Domain, Data, and Presentation layers. The app is built using Swift and SwiftUI for the views, following the MVVM architecture pattern. Various design patterns such as Repository, UseCases, and Factories are also utilized.

## Testing
Each layer has its own set of unit tests. Additionally, all tests can be run using the Continuous Integration (CI) layer. The code coverage is approximately 80%.

## Third-party Dependencies via SPM
- SDWebImageSwiftUI
