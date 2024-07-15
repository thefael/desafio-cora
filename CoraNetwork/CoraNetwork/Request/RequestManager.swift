import Foundation

public protocol RequestManaging {
    func execute<T: Decodable>(endpoint: Endpoint) async throws -> T
}

protocol InterceptedRequestManaging: AnyObject {
    func request<T: Decodable>(fromEndpoint endpoint: Endpoint) async throws -> T
}

public class RequestManager: RequestManaging, InterceptedRequestManaging {
    public let urlSession: URLSession
    public let decoder: JSONDecoder
    public let interceptors: [Interceptor]
    
    public static var `default`: RequestManager = {
        let interceptor = TokenInterceptor()
        let requestManager = RequestManager(interceptors: [interceptor])
        interceptor.requestManager = requestManager
        return requestManager
    }()
    
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = .init(),
        interceptors: [Interceptor] = []
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
        self.interceptors = interceptors
    }
    
    public func execute<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let endpoint: Endpoint = try await intercept(endpoint)
        return try await request(fromEndpoint: endpoint)
    }
    
    func intercept(_ endpoint: Endpoint) async throws -> Endpoint {
        var endpoint = endpoint
        endpoint = try await interceptors.reduce(endpoint) { endpoint, interceptor in
            return try await interceptor.intercept(endpoint: endpoint)
        }
        return endpoint
    }
    
    func request<T: Decodable>(fromEndpoint endpoint: Endpoint) async throws -> T {
        guard let request = Self.buildRequest(endpoint) else {
            throw ApiError.badRequest
        }
        let (data, response) = try await urlSession.data(for: request)
        return try handle(data: data, response: response)
    }
}
    
private extension RequestManager {
    static func buildRequest(_ endpoint: Endpoint) -> URLRequest? {
        guard let url = endpoint.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(endpoint.contentType.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        urlRequest.addValue(ConfigLoader.getConfigProperty(.apiKey), forHTTPHeaderField: HttpHeaderField.apiKey.rawValue)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        return addHeaders(endpoint.headers, toRequest: urlRequest)
    }
    
    func handle<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch response.statusCode {
        case StatusCode.ok:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw ApiError.decodingError
            }
        case StatusCode.unauthorized:
            throw ApiError.unauthorized
        default:
            throw ApiError.invalidResponse
        }
    }
    
    static func addHeaders(_ headers: [String: String], toRequest request: URLRequest) -> URLRequest {
        var req = request
        for (key, value) in headers {
            req.addValue(value, forHTTPHeaderField: key)
        }
        return req
    }
}

public enum ApiError: Error {
    case badRequest
    case decodingError
    case unauthorized
    case invalidResponse
}
