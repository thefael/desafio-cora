import Foundation
import CoraNetwork

protocol PasswordValidationServicing {
    func authenticate(credential: Credential) async throws -> Access
}

final class PasswordValidationService: PasswordValidationServicing {
    let requestManager = RequestManager()
    
    func authenticate(credential: Credential) async throws -> Access {
        try await requestManager.execute(endpoint: CoraEndpoint.auth(credential: credential))
    }
}
