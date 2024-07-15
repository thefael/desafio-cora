@testable import CoraNetwork
import XCTest

final class RequestManagerTests: XCTestCase {
    func test_intercept_shouldCallAllIntercept() async throws {
        let interceptors = [InterceptorMock(), InterceptorMock()]
        let expectations = [
            expectation(description: "didCallIntercept1"),
            expectation(description: "didCallIntercept2")
        ]
        var id = 0
        await zip(interceptors, expectations).forEach { interceptor, expectation in
            interceptor.interceptAction = {
                expectation.fulfill()
                var endpoint = $0
                endpoint.headers["\(id)"] = "\(id)"
                id += 1
                return endpoint
            }
        }
        var expectedEndpoint = EndpointMock()
        expectedEndpoint.headers = ["0": "0", "1": "1"]
        let sut = makeSut(interceptors: interceptors)
        
        let intercepedEndpoint: any Endpoint = try await sut.intercept(EndpointMock())
        
        XCTAssertEqual(intercepedEndpoint as! EndpointMock, expectedEndpoint)
        await fulfillment(of: expectations, timeout: 0.1)
    }
}

extension Zip2Sequence {
    func forEach(_ body: (Self.Element) async throws -> Void) async rethrows {
        for element in self {
            try await body(element)
        }
    }
}

extension RequestManagerTests {
    func makeSut(interceptors: [Interceptor]) -> RequestManager {
        RequestManager(interceptors: interceptors)
    }
}
