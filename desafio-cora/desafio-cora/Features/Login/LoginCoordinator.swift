import UIKit

protocol LoginCoordinating {
    func openCpfValidationScreen()
    func openPasswordValidationScreen()
}

final class LoginCoordinator: LoginCoordinating {
    weak var navigationController: UINavigationController?
    
    func openCpfValidationScreen() {
        guard let navigationController else { return }
        let vc = CpfValidationFactory.make(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openPasswordValidationScreen() {
        guard let navigationController else { return }
        let vc = PasswordValidationFactory.make(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
