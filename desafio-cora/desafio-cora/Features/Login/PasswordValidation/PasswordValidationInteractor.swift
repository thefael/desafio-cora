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
    
    init(
        cpf: String,
        presenter: PasswordValidationPresenting,
        service: PasswordValidationServicing
    ) {
        self.cpf = cpf
        self.presenter = presenter
        self.service = service
    }
    
    func loadScreen() {
        presenter.presentScreen()
    }
    
    func login(password: String) {
        Task {
            do {
                let access = try await service.authenticate(credential: .init(cpf: cpf, password: password))
                print(access.token)
            } catch {
                print(error)
            }
        }
    }
}
