import CoraDesignSystem
import UIKit

protocol PasswordValidationDisplay: AnyObject {
    func display(viewModel: LoginView.ViewModel)
}

final class PasswordValidationViewController: UIViewController {
    private var interactor: PasswordValidationInteracting
    let loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.focusOntextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    init(interactor: PasswordValidationInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasswordValidationViewController: PasswordValidationDisplay {
    func display(viewModel: LoginView.ViewModel) {
        loginView.configureView(usingViewModel: viewModel)
        loginView.button.enable(false)
        loginView.textField.delegate = self
        loginView.button.action { [weak self] in
            guard let password = self?.loginView.textField.textField.text else { return }
            self?.interactor.login(password: password)
        }
    }
}

extension PasswordValidationViewController: TextFieldDelegate {
    var keyBoardType: UIKeyboardType {
        .default
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        loginView.button.enable(updatedText.isValidPassword)
        return true
    }
}
