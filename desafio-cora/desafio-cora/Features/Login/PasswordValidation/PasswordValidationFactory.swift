import UIKit

enum PasswordValidationFactory {
    static func make(navigationController: UINavigationController) -> UIViewController {
        let coordinator = LoginCoordinator()
        coordinator.navigationController = navigationController
        let presenter = PasswordValidationPresenter(coordinator: coordinator)
        let interactor = PasswordValidationInteractor(presenter: presenter)
        let viewController = PasswordValidationViewController(interactor: interactor)
        presenter.display = viewController
        return viewController
    }
}
