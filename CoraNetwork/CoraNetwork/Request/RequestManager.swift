import Foundation

public protocol Interceptor {
    func intercept(endpoint: Endpoint) async -> Endpoint
}

public class RequestManager {
    public let urlSession: URLSession
    public let decoder: JSONDecoder
    public lazy var interceptors: [Interceptor] = [
        TokenManager(requestManager: self)
    ]
    
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = .init()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    public func execute<T: Decodable>(endpoint: Endpoint) async throws -> T {
        var endpoint: Endpoint = await intercept(endpoint)
        return try await request(fromEndpoint: endpoint)
    }
    
    func intercept(_ endpoint: Endpoint) async -> Endpoint {
        var endpoint = endpoint
        if endpoint.path != "/challenge/auth" {
            endpoint = await interceptors.reduce(endpoint) { endpoint, interceptor in
                return await interceptor.intercept(endpoint: endpoint)
            }
        }
        return endpoint
    }
    
    func request<T: Decodable>(fromEndpoint endpoint: Endpoint) async throws -> T {
        guard let request = Self.buildRequest(endpoint) else {
            throw ApiError.badRequest
        }
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            return try handle(data: data, response: response)
        } catch {
            throw error
        }
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
