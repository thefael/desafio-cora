import Foundation

final class TokenManager: Interceptor {
    private let repository: Repository
    weak var requestManager: RequestManager?
    
    init(
        requestManager: RequestManager? = nil,
        repository: Repository = DefaultRepository()
    ) {
        self.requestManager = requestManager
        self.repository = repository
    }
    
    func intercept(endpoint: Endpoint) async -> Endpoint {
        var endpoint = endpoint
        guard let accessToken: AccessToken = repository.getValue(forKey: .accessToken), let date = accessToken.timeStamp, date.isExpired, let requestManager
        else { return endpoint }
        
        do {
            let refreshTokenEndpoint = TokenEndpoint.refreshToken(accessToken)
            var refreshToken: AccessToken = try await requestManager.request(fromEndpoint: refreshTokenEndpoint)
            refreshToken.timeStamp = Date()
            repository.store(value: refreshToken, forKey: .accessToken)
            endpoint.headers["token"] = refreshToken.token
        } catch {
            return endpoint
        }
        
        return endpoint
    }
}
