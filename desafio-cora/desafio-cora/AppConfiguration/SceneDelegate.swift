import UIKit
import CoraDesignSystem

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let viewController = WelcomeFactory.make(navigationController)
//        let viewController = ExtractDetailViewController()
        navigationController.pushViewController(viewController, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

final class StyledNavigationController: UINavigationController {
    
}

