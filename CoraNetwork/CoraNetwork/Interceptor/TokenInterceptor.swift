import Foundation

final class TokenInterceptor: Interceptor {
    private let repository: Repository
    weak var requestManager: RequestManager?
    
    init(
        requestManager: RequestManager? = nil,
        repository: Repository = DefaultRepository()
    ) {
        self.requestManager = requestManager
        self.repository = repository
    }
    
    func intercept(endpoint: Endpoint) async throws -> Endpoint {
        var endpoint = endpoint
        guard let accessToken: AccessToken = repository.getValue(forKey: .accessToken) else { throw ApiError.unauthorized }
        guard let date = accessToken.timeStamp, date.isExpired, let requestManager
        else {
            endpoint.headers["token"] = accessToken.token
            return endpoint
        }
        
        let refreshTokenEndpoint = TokenEndpoint.refreshToken(accessToken)
        var refreshToken: AccessToken = try await requestManager.request(fromEndpoint: refreshTokenEndpoint)
        refreshToken.timeStamp = Date()
        repository.store(value: refreshToken, forKey: .accessToken)
        endpoint.headers["token"] = refreshToken.token
        
        return endpoint
    }
}
