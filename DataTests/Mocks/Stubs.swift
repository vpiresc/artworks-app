import Foundation
import Domain

enum Stubs {
    static func makefetchArtworksModelStub() -> String {
                """
                {
                "pagination": {
                "next_url": "https://api.artic.edu/api/v1/artworks?page=2&limit=10"
                },
                "data": [
                {
                "id": 3816,
                "title": "Ornamental Panel With Two Lovers",
                "thumbnail": {
                "lqip": "data:image/gif;base64,R0lGODlhBwAFAPQAAGpoVXJxXXRyXXVzXnd2Ynh2YHh3Ynl3Y3l3ZHt5ZHt5ZX17ZXx6Zn17Znx6Z358ZoB+aIF+aYF/aYB/a4J/a4OAaoKAa4OBa4KAbYOBbYWDb4aEb42LdI6Md4+MeAAAACH5BAAAAAAALAAAAAAHAAUAAAUdoBMYVzJo0wFxT9VhzbVZkccUSyM1GQIIBMWBEgIAOw==",
                "width": 3372,
                "height": 2284,
                "alt_text": "A work made of engraving printed in black, on ivory laid paper."
                },
                "artist_id": 37116
                }
                    ],
                }
                """
    }
    
    static func makefetchArtworksArtistModelStub() -> String {
                """
                {
                "data": {
                "id": 33909,
                "api_model": "agents",
                "api_link": "https://api.artic.edu/api/v1/agents/33909",
                "title": "Marc Chagall"
                    }
                }
                """
    }
    
    static func makePaginationStub() -> String {
            """
                {
                "pagination": {
                "next_url": "https://api.artic.edu/api/v1/artworks?page=2&limit=10"
                }
                }
                """
    }
    
    static func makeArtworksStub() -> String {
            """
                {
                "id": 1,
                "artist_id": 1,
                "title": "artist title",
                "thumbnail": {
                "lqip": "data:image/gif;base64,R0lGODlhBwAFAPQAAGpoVXJxXXRyXXVzXnd2Ynh2YHh3Ynl3Y3l3ZHt5ZHt5ZX17ZXx6Zn17Znx6Z358ZoB+aIF+aYF/aYB/a4J/a4OAaoKAa4OBa4KAbYOBbYWDb4aEb42LdI6Md4+MeAAAACH5BAAAAAAALAAAAAAHAAUAAAUdoBMYVzJo0wFxT9VhzbVZkccUSyM1GQIIBMWBEgIAOw==",
                "width": 3372,
                "height": 2284,
                "alt_text": "A work made of engraving printed in black, on ivory laid paper."
                }
                }
                """
    }
    
    static func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
    }
    
    static func makeArtworksValidData() -> Data {
        return Data(Stubs.makefetchArtworksModelStub().utf8)
    }
    
    static func makeArtworksArtistValidData() -> Data {
        return Data(Stubs.makefetchArtworksArtistModelStub().utf8)
    }
    
    static func makeUrl() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    static func makeError() -> Error {
        return NSError(domain: "any_error", code: 0)
    }
    
    static func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
        return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
