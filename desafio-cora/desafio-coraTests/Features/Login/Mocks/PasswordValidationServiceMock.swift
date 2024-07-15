@testable import desafio_cora
import CoraNetwork

final class PasswordValidationServiceMock: PasswordValidationServicing {
    var authenticateAction: ((Credential) async throws -> AccessToken)?
    
    func authenticate(credential: Credential) async throws -> AccessToken {
        try await authenticateAction!(credential)
    }
}
