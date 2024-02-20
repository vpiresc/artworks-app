import Foundation

enum ResponseType {
    case success
    case failure
}

enum ResponseErrorMock: Error {
    case failedFetching
}
