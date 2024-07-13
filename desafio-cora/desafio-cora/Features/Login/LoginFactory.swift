import UIKit

enum LoginFactory {
    static func make() -> UIViewController {
        let presenter = LoginPresenter()
        let viewController = LoginViewController(presenter: presenter)
        return viewController
    }
}
