import UIKit

enum WelcomeFactory {
    static func make() -> UIViewController {
        let presenter = WelcomePresenter()
        let viewController = WelcomeViewController(presenter: presenter)
        
        return viewController
    }
}
