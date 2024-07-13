import UIKit

protocol LoginCoordinating {
    func openCpfValidationScreen()
    func openPasswordValidationScreen(validCpf: String)
}

final class LoginCoordinator: LoginCoordinating {
    weak var navigationController: UINavigationController?
    
    func openCpfValidationScreen() {
        guard let navigationController else { return }
        let vc = CpfValidationFactory.make(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openPasswordValidationScreen(validCpf: String) {
        guard let navigationController else { return }
        let vc = PasswordValidationFactory.make(navigationController: navigationController, validCpf: validCpf)
        navigationController.pushViewController(vc, animated: true)
    }
}
