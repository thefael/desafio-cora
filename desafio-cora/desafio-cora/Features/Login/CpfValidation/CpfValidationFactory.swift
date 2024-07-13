import UIKit

enum CpfValidationFactory {
    static func make(
        navigationController: UINavigationController
    ) -> UIViewController {
        let coordinator = LoginCoordinator()
        coordinator.navigationController = navigationController
        let presenter = CpfValidationPresenter(coordinator: coordinator)
        let interactor = CpfValidationInteractor(presenter: presenter)
        let viewController = CpfValidationViewController(interactor: interactor)
        presenter.display = viewController
        return viewController
    }
}
