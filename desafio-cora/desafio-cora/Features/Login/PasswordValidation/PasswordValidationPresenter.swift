import CoraDesignSystem

protocol PasswordValidationPresenting {
    func presentScreen()
    func presentExtractScreen()
    func presentAlert(errorTitle: String, errorMessage: String)
}

final class PasswordValidationPresenter {
    private let coordinator: LoginCoordinating
    weak var display: PasswordValidationDisplay?
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

extension PasswordValidationPresenter: PasswordValidationPresenting {
    func presentScreen() {
        display?.display(viewModel: .password)
    }
    
    func presentExtractScreen() {
        coordinator.openExtractScreen()
    }
    
    func presentAlert(errorTitle: String, errorMessage: String) {
        display?.displayAlert(title: errorTitle, message: errorMessage)
    }
}
