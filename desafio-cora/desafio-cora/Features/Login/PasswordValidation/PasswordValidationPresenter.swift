import CoraDesignSystem

protocol PasswordValidationPresenting {
    func presentScreen()
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
}
