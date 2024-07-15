import CoraDesignSystem

protocol CpfValidationPresenting {
    func presentScreen()
    func presentPasswordValidationScreen(validCpf: String)
    func presentHint()
}

final class CpfValidationPresenter {
    private let coordinator: LoginCoordinating
    weak var display: CpfValidationDisplay?
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

extension CpfValidationPresenter: CpfValidationPresenting {
    func presentScreen() {
        display?.display(viewModel: .cpf)
    }
    
    func presentPasswordValidationScreen(validCpf: String) {
        coordinator.openPasswordValidationScreen(validCpf: validCpf)
    }
    
    func presentHint() {
        display?.display(hint: LoginLocalizedStrings.cpfHintText.localized)
    }
}
