import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get set }
    var url: URL? { get }
}

public extension Endpoint {
    var method: HTTPMethod { .get }
    var scheme: String { "https" }
    var queryItems: [URLQueryItem] { [] }
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    mutating func addQueryItem(key: QueryItemKey, value: String?) {
        queryItems.append(
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
