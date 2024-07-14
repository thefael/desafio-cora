public protocol Repository {
    func store<T: Codable>(value: T, forKey key: RepositoryKey)
    func getValue<T: Codable>(forKey key: RepositoryKey) -> T?
}

public struct DefaultRepository: Repository {
    public func store<T: Codable>(value: T, forKey key: RepositoryKey) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }

    public func getValue<T: Codable>(forKey key: RepositoryKey) -> T? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key.rawValue), let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
        return nil
    }
    
    public init() { }
}

public enum RepositoryKey: String {
    case accessToken
}
