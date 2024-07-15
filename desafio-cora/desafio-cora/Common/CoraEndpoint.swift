import Foundation
import CoraNetwork

public struct CoraEndpoint: Endpoint {
    public var headers: [String : String] = [:]
    public var queryItems: [URLQueryItem]? = nil
    public var baseUrl: String = ConfigLoader.getConfigProperty(.baseUrl)
    public var path: String
    public var method: HTTPMethod = .get
    public var contentType: ContentType = .applicationJson
    public var body: Data? = nil
}

extension CoraEndpoint {
    public static func auth(credential: Credential) -> Self {
        .init(path: "/challenge/auth", method: .post, body: toData(credential))
    }
    
    public static func extract() -> Self {
        .init(
            headers: ["Cache-Control": "no-cache"],
            path: "/challenge/list"
        )
    }
    
    public static func extractDetail(id: String) -> Self {
        .init(
            headers: ["Cache-Control": "no-cache"],
            path: "/challenge/details/\(id)"
        )
    }
}
