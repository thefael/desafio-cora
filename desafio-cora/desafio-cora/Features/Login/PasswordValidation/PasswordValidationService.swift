import Foundation
import CoraNetwork

protocol PasswordValidationServicing {
    func authenticate(credential: Credential) async throws -> AccessToken
}

final class PasswordValidationService: PasswordValidationServicing {
    let requestManager = RequestManager()
    
    func authenticate(credential: Credential) async throws -> AccessToken {
        try await requestManager.execute(endpoint: CoraEndpoint.auth(credential: credential))
    }
}
