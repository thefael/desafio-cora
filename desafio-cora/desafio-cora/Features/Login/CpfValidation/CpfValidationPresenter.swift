import CoraDesignSystem

protocol CpfValidationPresenting {
    func presentScreen()
    func presentPasswordValidationScreen()
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
    
    func presentPasswordValidationScreen() {
        coordinator.openPasswordValidationScreen()
    }
    
    func presentHint() {
        display?.display(hint: "Digite um CPF válido.")
    }
}
