import UIKit

enum ExtractDetailFactory {
    static func make(navigationController: UINavigationController, id: String) -> UIViewController {
        let service = ExtractDetailService()
        let presenter = ExtractDetailPresenter()
        let interactor = ExtractDetailInteractor(service: service, presenter: presenter, id: id)
        let viewController = ExtractDetailViewController(interactor: interactor)
        presenter.display = viewController
        return viewController
    }
}
