import Foundation

protocol CpfValidationInteracting {
    var cpfIsValid: Bool { get set }
    func loadScreen()
    func validateCpf()
}

final class CpfValidationInteractor: CpfValidationInteracting {
    private let presenter: CpfValidationPresenting
    var cpfIsValid: Bool = false
    
    init(presenter: CpfValidationPresenting) {
        self.presenter = presenter
    }
    
    func loadScreen() {
        presenter.presentScreen()
    }
    
    func validateCpf() {
        if cpfIsValid {
            presenter.presentPasswordValidationScreen()
        } else {
            presenter.presentHint()
        }
    }
}
