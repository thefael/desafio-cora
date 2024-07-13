import Foundation

protocol PasswordValidationInteracting {
    func loadScreen()
}

final class PasswordValidationInteractor: PasswordValidationInteracting {
    private let presenter: PasswordValidationPresenting
    
    init(presenter: PasswordValidationPresenting) {
        self.presenter = presenter
    }
    
    func loadScreen() {
        presenter.presentScreen()
    }
}
