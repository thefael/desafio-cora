@testable import CoraNetwork

final class InterceptedRequestManagerMock<S: Decodable>: InterceptedRequestManaging {
    var requestAction: ((Endpoint) async throws -> S)?
    func request<T: Decodable>(fromEndpoint endpoint: Endpoint) async throws -> T {
        try await requestAction!(endpoint) as! T
    }
}
