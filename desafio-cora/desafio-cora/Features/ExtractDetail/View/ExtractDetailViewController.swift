import CoraDesignSystem
import UIKit

protocol ExtractDetailDisplay: AnyObject {
    func display(viewModel: ExtractDetailView.ViewModel)
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
}
