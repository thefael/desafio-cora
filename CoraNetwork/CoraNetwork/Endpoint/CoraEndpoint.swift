import Foundation

public struct CoraEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? = nil
    public var baseUrl: String = ConfigLoader.getConfigProperty(.baseUrl)
    public var path: String
    public var method: HTTPMethod = .get
    public var body: Data? = nil
}

extension CoraEndpoint {
    public static func auth(credential: Credential) -> Self {
        .init(path: "/challenge/auth", method: .post, body: toData(credential))
    }
}
