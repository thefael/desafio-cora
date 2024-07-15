import UIKit

enum ExtractFactory {
    static func make(_ navigationController: UINavigationController) -> UIViewController {
        let service = ExtractService()
        let coordinator = ExtractCoordinator(navigationController: navigationController)
        let presenter = ExtractPresenter(coordinator: coordinator)
        let interactor = ExtractInteractor(service: service, presenter: presenter)
        let viewController = ExtractViewController(interactor: interactor)
        presenter.display = viewController
        
        return viewController
    }
}
