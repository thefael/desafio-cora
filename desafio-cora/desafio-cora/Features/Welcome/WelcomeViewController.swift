import UIKit
import CoraNetwork
import CoraDesignSystem

final class WelcomeViewController: UIViewController {
    private lazy var welcomeView: WelcomeView = {
        let view = WelcomeView()
        view.loginButton.action {
            self.presenter.presentLoginScreen()
        }
        return view
    }()
    private let presenter: WelcomePresenting
    
    init(presenter: WelcomePresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        welcomeView.configureView(usingViewModel: presenter.viewModel)
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

