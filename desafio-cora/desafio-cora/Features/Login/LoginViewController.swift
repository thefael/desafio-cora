import UIKit
import CoraDesignSystem

final class LoginViewController: UIViewController {
    private let presenter: LoginPresenting
    let loginView = LoginView()
    
    override func loadView() {
        loginView.configureView(usingViewModel: presenter.viewModel)
        loginView.textField.delegate = self
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.focusOntextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: TextFieldDelegate {
    var keyBoardType: UIKeyboardType {
        .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let sanitizedText = updatedText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let formattedText = sanitizedText.applyCpfMask()
        textField.text = formattedText
        return false
    }
}

