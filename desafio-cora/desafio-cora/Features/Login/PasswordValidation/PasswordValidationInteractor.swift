import Foundation
import CoraNetwork

protocol PasswordValidationInteracting {
    func loadScreen()
    func login(password: String)
}

final class PasswordValidationInteractor: PasswordValidationInteracting {
    private let presenter: PasswordValidationPresenting
    private let service: PasswordValidationServicing
    private let cpf: String
    private let repository: Repository
    
    init(
        cpf: String,
        presenter: PasswordValidationPresenting,
        service: PasswordValidationServicing,
        repository: Repository = DefaultRepository()
    ) {
        self.cpf = cpf
        self.presenter = presenter
        self.service = service
        self.repository = repository
    }
    
    func loadScreen() {
        presenter.presentScreen()
    }
    
    func login(password: String) {
        Task { @MainActor in
            do {
                var accessToken = try await service.authenticate(credential: .init(cpf: cpf, password: password))
                accessToken.timeStamp = Date()
                repository.store(value: accessToken, forKey: .accessToken)
            } catch {
                print(error)
            }
        }
    }
}
