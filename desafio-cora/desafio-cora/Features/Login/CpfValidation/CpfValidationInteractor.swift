import Foundation

protocol CpfValidationInteracting {
    var cpfToValidate: String { get set }
    func loadScreen()
    func validateCpf()
}

final class CpfValidationInteractor: CpfValidationInteracting {
    private let presenter: CpfValidationPresenting
    var cpfToValidate: String = ""
    
    init(presenter: CpfValidationPresenting) {
        self.presenter = presenter
    }
    
    func loadScreen() {
        presenter.presentScreen()
    }
    
    func validateCpf() {
        if cpfToValidate.isValidCpf {
            presenter.presentPasswordValidationScreen(validCpf: cpfToValidate)
        } else {
            presenter.presentHint()
        }
    }
}
