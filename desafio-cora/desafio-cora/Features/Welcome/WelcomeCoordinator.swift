import Foundation
import UIKit

protocol WelcomeCoordinating {
    func open()
}

final class WelcomeCoordinator: WelcomeCoordinating {
    weak var navigationController: UINavigationController?
    
    func open() {
        // TODO: criar tela de login
    }
}
