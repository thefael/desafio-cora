import Foundation

public protocol Endpoint {
    var baseUrl: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var contentType: ContentType { get }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
    var headers: [String: String] { get set }
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
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
