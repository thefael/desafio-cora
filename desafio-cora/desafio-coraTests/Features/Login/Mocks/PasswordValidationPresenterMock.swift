@testable import desafio_cora

final class PasswordValidationPresenterMock: PasswordValidationPresenting {
    var presentScreenAction: (() -> Void)?
    var presentExtractScreenAction: (() -> Void)?
    var presentAlertAction: ((String, String) -> Void)?
    
    func presentScreen() {
        presentScreenAction?()
    }
    
    func presentExtractScreen() {
        presentExtractScreenAction?()
    }
    
    func presentAlert(errorTitle: String, errorMessage: String) {
        presentAlertAction?(errorTitle, errorMessage)
    }
}
