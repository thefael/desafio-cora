@testable import CoraNetwork
import XCTest

final class TokenInterceptorTests: XCTestCase {
    func test_intercept_whenAccessTokenIsValid_shouldReturnCorrectEndpoint() async throws {
        let (doubles, sut) = makeSut()
        let date = Date()
        doubles.repository.getValueAction = { _ in
            .fixture(token: "correctToken", timeStamp: date)
        }
        
        let interceptedEndpoint = try await sut.intercept(endpoint: EndpointMock())
        
        XCTAssertEqual(interceptedEndpoint.headers["token"], "correctToken")
    }
    
    func test_intercept_whenAccessTokenIsInvalid_andRequestNewAccessTokenSucceeds_shouldStoreNewToken() async throws {
        let (doubles, sut) = makeSut()
        sut.refreshTokenEndpoint = { _ in EndpointMock() }
        let date = Date.distantPast
        doubles.repository.getValueAction = { _ in
            .fixture(token: "expiredToken", timeStamp: date)
        }
        let expectation1 = expectation(description: "didCallRequest")
        doubles.requestManager.requestAction = { _ in
            expectation1.fulfill()
            return .fixture(token: "correctToken")
        }
        let expectation2 = expectation(description: "didCallStore")
        doubles.repository.storeAction = { newToken, _ in
            XCTAssertEqual(newToken, .fixture(token: "correctToken"))
            expectation2.fulfill()
        }
        
        let interceptedEndpoint = try await sut.intercept(endpoint: EndpointMock())
        
        XCTAssertEqual(interceptedEndpoint.headers["token"], "correctToken")
        await fulfillment(of: [expectation1, expectation2], timeout: 0.1)
    }
    
    func test_intercept_whenAccessTokenIsNotStored_shouldThrowUnauthorizedError() async {
        let (doubles, sut) = makeSut()
        doubles.repository.getValueAction = { _ in nil }
        do {
            _ = try await sut.intercept(endpoint: EndpointMock())
            XCTFail()
        } catch {
            XCTAssertEqual(error as? ApiError, .unauthorized)
        }
    }
}

extension TokenInterceptorTests {
    class Doubles {
        let requestManager = InterceptedRequestManagerMock<AccessToken>()
        let repository = RepositoryMock<AccessToken>()
    }
    
    func makeSut() -> (Doubles, TokenInterceptor) {
        let doubles = Doubles()
        let sut = TokenInterceptor(
            repository: doubles.repository,
            timeStamp: nil,
            requestManager: doubles.requestManager
        )
        return (doubles, sut)
    }
}

extension AccessToken {
    static func fixture(
        token: String = "token",
        timeStamp: Date? = nil
    ) -> Self {
        .init(token: token, timeStamp: timeStamp)
    }
}

struct EndpointMock: Endpoint {
    var queryItems: [URLQueryItem]? = nil
    var baseUrl: String = "baseUrl"
    var path: String = "path"
    var body: Data? = nil
    var contentType: ContentType = .applicationJson
    var headers: [String : String] = [:]
}
