import Foundation
import UIKit

protocol ExtractCoordinating {
    func openDetailScreen(forId id: String)
}

final class ExtractCoordinator: ExtractCoordinating {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openDetailScreen(forId id: String) {
        let viewController = ExtractDetailFactory.make(navigationController: navigationController, id: id)
        navigationController.pushViewController(viewController, animated: true)
    }
}
