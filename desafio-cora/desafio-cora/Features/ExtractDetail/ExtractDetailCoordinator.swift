import UIKit

protocol ExtractDetailCoordinating {
    func dismiss()
    func navigateToRoot()
}

final class ExtractDetailCoordinator: ExtractDetailCoordinating {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
