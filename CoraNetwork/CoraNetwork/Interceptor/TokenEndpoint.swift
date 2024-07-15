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

public struct AccessToken: Codable, Equatable {
    public let token: String
    public var timeStamp: Date?
    
    public init(token: String, timeStamp: Date? = nil) {
        self.token = token
        self.timeStamp = timeStamp
    }
}

public struct ExpiredToken: Codable {
    public let token: String
}

#if DEBUG
public extension AccessToken {
    static func fixture(
        token: String = "token",
        timeStamp: Date? = nil
    ) -> Self {
        .init(token: token, timeStamp: timeStamp)
    }
}
#endif
