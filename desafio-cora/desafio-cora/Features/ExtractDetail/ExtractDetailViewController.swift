import CoraDesignSystem
import UIKit

final class ExtractDetailViewController: UIViewController {
    private let extractDetailView = ExtractDetailView()
    
    override func loadView() {
        view = extractDetailView
    }
}
