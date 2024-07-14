import UIKit

enum ExtractFactory {
    static func make() -> UIViewController {
        let service = ExtractService()
        let presenter = ExtractPresenter()
        let interactor = ExtractInteractor(service: service, presenter: presenter)
        let viewController = ExtractViewController(interactor: interactor)
        presenter.display = viewController
        
        return viewController
    }
}
