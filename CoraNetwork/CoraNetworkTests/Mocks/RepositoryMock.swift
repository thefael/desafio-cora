@testable import CoraNetwork

final class RepositoryMock<S: Codable>: Repository {
    var storeAction: ((S, RepositoryKey) -> Void)?
    var getValueAction: ((RepositoryKey) -> S?)?
    
    func store<T>(value: T, forKey key: RepositoryKey) where T: Codable {
        storeAction?(value as! S, key)
    }
    
    func getValue<T>(forKey key: RepositoryKey) -> T? where T: Codable {
        getValueAction?(key) as? T
    }
}
