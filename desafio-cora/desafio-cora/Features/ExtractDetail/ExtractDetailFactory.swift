import UIKit

enum ExtractDetailFactory {
    static func make(navigationController: UINavigationController, id: String, entry: ExtractList.Section.Item.Entry) -> UIViewController {
        let service = ExtractDetailService()
        let presenter = ExtractDetailPresenter()
        let interactor = ExtractDetailInteractor(
            service: service,
            presenter: presenter,
            id: id,
            entry: entry
        )
        let viewController = ExtractDetailViewController(interactor: interactor)
        presenter.display = viewController
        return viewController
    }
}
