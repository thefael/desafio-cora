import Foundation

final class TokenInterceptor: Interceptor {
    private let repository: Repository
    private let timeStamp: (() -> Date)?
    weak var requestManager: InterceptedRequestManaging?
    var refreshTokenEndpoint: (AccessToken) -> Endpoint = TokenEndpoint.refreshToken
    
    init(
        repository: Repository = DefaultRepository(),
        timeStamp: (() -> Date)? = Date.init,
        requestManager: InterceptedRequestManaging? = nil
    ) {
        self.repository = repository
        self.timeStamp = timeStamp
        self.requestManager = requestManager
    }
    
    func intercept(endpoint: Endpoint) async throws -> Endpoint {
        var endpoint = endpoint
        guard let accessToken: AccessToken = repository.getValue(forKey: .accessToken) else { throw ApiError.unauthorized }
        guard let date = accessToken.timeStamp, date.isExpired, let requestManager
        else {
            endpoint.headers["token"] = accessToken.token
            return endpoint
        }
        
        let refreshTokenEndpoint = refreshTokenEndpoint(accessToken)
        var refreshToken: AccessToken = try await requestManager.request(fromEndpoint: refreshTokenEndpoint)
        refreshToken.timeStamp = timeStamp?()
        repository.store(value: refreshToken, forKey: .accessToken)
        endpoint.headers["token"] = refreshToken.token
        
        return endpoint
    }
}
