import UIKit

enum WelcomeFactory {
    static func make(_ navigationController: UINavigationController) -> UIViewController {
        let coordinator = WelcomeCoordinator()
        coordinator.navigationController = navigationController
        let presenter = WelcomePresenter(coordinator: coordinator)
        let viewController = WelcomeViewController(presenter: presenter)
        
        return viewController
    }
}
