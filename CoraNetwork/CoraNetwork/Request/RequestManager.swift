import Foundation

public class RequestManager {
    public let urlSession: URLSession
    public let decoder: JSONDecoder
    
    public init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = .init()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    public func execute<T: Decodable>(endpoint: Endpoint) async throws -> T {
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
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("79b5f54918628cc7f6a900a386d14a04", forHTTPHeaderField: QueryItemKey.apiKey.rawValue)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        return urlRequest
    }
    
    func handle<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch response.statusCode {
        case 200:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw ApiError.decodingError
            }
        case 401:
            throw ApiError.unauthorized
        default:
            throw ApiError.invalidResponse
        }
    }
}

public enum ApiError: Error {
    case badRequest
    case decodingError
    case unauthorized
    case invalidResponse
}
