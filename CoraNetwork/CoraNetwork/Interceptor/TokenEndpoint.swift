public struct TokenEndpoint: Endpoint {
    public var headers: [String : String] = [:]
    public var queryItems: [URLQueryItem]? = nil
    public var baseUrl: String = ConfigLoader.getConfigProperty(.baseUrl)
    public var path: String
    public var method: HTTPMethod = .get
    public var contentType: ContentType = .applicationJson
    public var body: Data? = nil
    
    static func refreshToken(_ expiredToken: AccessToken) -> Self {
        .init(path: "/challenge/auth", method: .post, body: toData(ExpiredToken(token: expiredToken.token)))
    }
}

public struct AccessToken: Codable {
    public let token: String
    public var timeStamp: Date?
}

public struct ExpiredToken: Codable {
    public let token: String
}
