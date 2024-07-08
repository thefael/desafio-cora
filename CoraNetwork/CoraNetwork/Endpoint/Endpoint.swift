import Foundation

public protocol Endpoint {
    var baseUrl: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
}

public extension Endpoint {
    var method: HTTPMethod { .get }
    var scheme: String { "https" }
    var queryItems: [URLQueryItem]? { nil }
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseUrl
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    mutating func addQueryItem(key: QueryItemKey, value: String?) {
        guard queryItems != nil else {
            queryItems = [.init(name: key.rawValue, value: value)]
            return
        }
        
        queryItems?.append(
            .init(
                name: key.rawValue,
                value: value
            )
        )
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
