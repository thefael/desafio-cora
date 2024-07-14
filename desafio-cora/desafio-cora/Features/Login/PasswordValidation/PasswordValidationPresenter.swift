import CoraDesignSystem

protocol PasswordValidationPresenting {
    func presentScreen()
    func presentExtractScreen()
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
}
