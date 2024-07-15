@testable import desafio_cora

final class CpfValidationPresenterMock: CpfValidationPresenting {
    var presentScreenAction: (() -> Void)?
    var presentPasswordValidationScreenAction: ((String) -> Void)?
    var presentHintAction: (() -> Void)?
    
    func presentScreen() {
        presentScreenAction?()
    }
    
    func presentPasswordValidationScreen(validCpf: String) {
        presentPasswordValidationScreenAction?(validCpf)
    }
    
    func presentHint() {
        presentHintAction?()
    }
}
