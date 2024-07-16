import Foundation
import UIKit

protocol ExtractCoordinating {
    func openDetailScreen(forId id: String, entry: ExtractList.Section.Item.Entry)
    func navigateToRoot()
}

final class ExtractCoordinator: ExtractCoordinating {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openDetailScreen(forId id: String, entry: ExtractList.Section.Item.Entry) {
        let viewController = ExtractDetailFactory.make(navigationController: navigationController, id: id, entry: entry)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
