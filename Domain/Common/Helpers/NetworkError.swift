public enum NetworkError: Error {
    case invalidUrl
    case invalidServerResponse
    case unableToFetch
    case unauthorized
    case forbidden
    case badRequest
    case serverError
    case noConnectivity
}
