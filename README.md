# About the Artworks App
The Artworks App is a simple application that displays a list of artworks from the [Art Institute of Chicago API](https://api.artic.edu/docs/) along with some detailed information about each artwork.

## Technical Details
- The project is organized into `Domain`, `Data`, and `Presentation` layers. The app is built using Swift and SwiftUI for the views, following the `Model-View-ViewModel`(MVVM) architecture pattern. This architectural choice enhances separation of concerns and facilitates testability. 

- Various design patterns such as `Repository`, `UseCases`, and `Factories` are also utilized. These patterns help in organizing code logic and promoting reusability.

- The `async-await` pattern is used to handle errors with `throws`, allowing for asynchronous error handling in a more readable and maintainable way.

- By implementing these technologies and patterns, the project aims to achieve a clean, scalable, and maintainable codebase.

## Testing
Each layer has its own set of unit tests. Additionally, all tests can be run using the `Continuous Integration` (CI) layer. The code coverage is approximately 80%.

## Third-party Dependencies via SPM
- SDWebImageSwiftUI
