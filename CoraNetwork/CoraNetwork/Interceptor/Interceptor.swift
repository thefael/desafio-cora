public protocol Interceptor {
    func intercept(endpoint: Endpoint) async throws -> Endpoint
}
