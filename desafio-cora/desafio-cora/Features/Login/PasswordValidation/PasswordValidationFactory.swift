import UIKit

enum PasswordValidationFactory {
    static func make(
        navigationController: UINavigationController,
        validCpf: String
    ) -> UIViewController {
        let coordinator = LoginCoordinator()
        coordinator.navigationController = navigationController
        let presenter = PasswordValidationPresenter(coordinator: coordinator)
        let service = PasswordValidationService()
        let interactor = PasswordValidationInteractor(
            cpf: validCpf,
            presenter: presenter,
            service: service
        )
        let viewController = PasswordValidationViewController(interactor: interactor)
        presenter.display = viewController
        return viewController
    }
}
