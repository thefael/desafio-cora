import Foundation
import UIKit

protocol WelcomeCoordinating {
    func open()
}

final class WelcomeCoordinator: WelcomeCoordinating {
    weak var navigationController: UINavigationController?
    
    func open() {
        guard let navigationController else { return }
        let vc = CpfValidationFactory.make(navigationController: navigationController)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.navigationItem.title = "Login Cora"
        navigationController.pushViewController(vc, animated: true)
    }
}
