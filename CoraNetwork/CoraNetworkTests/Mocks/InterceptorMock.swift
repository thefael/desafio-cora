@testable import CoraNetwork

final class InterceptorMock: Interceptor {
    var interceptAction: ((Endpoint) async throws -> Endpoint)?
    func intercept(endpoint: Endpoint) async throws -> Endpoint {
        try await interceptAction!(endpoint)
    }
}
