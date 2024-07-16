import CoraDesignSystem
import UIKit

protocol ExtractDetailDisplay: AnyObject {
    func display(viewModel: ExtractDetailView.ViewModel)
    func displayAlert(type: AlertType, title: String, message: String, buttonCaption: String)
}

final class ExtractDetailViewController: UIViewController {
    private let extractDetailView = ExtractDetailView()
    private let interactor: ExtractDetailInteracting
    
    init(interactor: ExtractDetailInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = extractDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
}

extension ExtractDetailViewController: ExtractDetailDisplay {
    func display(viewModel: ExtractDetailView.ViewModel) {
        extractDetailView.configure(usingViewModel: viewModel)
    }
    
    func displayAlert(type: AlertType, title: String, message: String, buttonCaption: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action: UIAlertAction = .init(title: buttonCaption, style: .default) { [weak self] _ in
            self?.interactor.didTapAlertButton(type: type)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
