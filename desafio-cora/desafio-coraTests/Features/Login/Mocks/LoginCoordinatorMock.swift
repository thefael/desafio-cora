@testable import desafio_cora

final class LoginCoordinatorMock: LoginCoordinating {
    var openCpfValidationScreenAction: (() -> Void)?
    var openPasswordValidationScreenAction: ((String) -> Void)?
    var openExtractScreenAction: (() -> Void)?
    
    func openCpfValidationScreen() {
        openCpfValidationScreenAction?()
    }
    
    func openPasswordValidationScreen(validCpf: String) {
        openPasswordValidationScreenAction?(validCpf)
    }
    
    func openExtractScreen() {
        openExtractScreenAction?()
    }
}
