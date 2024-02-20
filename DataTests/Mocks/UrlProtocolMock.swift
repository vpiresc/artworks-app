import Foundation

class UrlProtocolMock: URLProtocol {
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?

    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolMock.data = data
        UrlProtocolMock.response = response
        UrlProtocolMock.error = error
    }

    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open func startLoading() {
        if let data = UrlProtocolMock.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolMock.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolMock.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override open func stopLoading() {}
}
