import CoraDesignSystem
import UIKit

protocol CpfValidationDisplay: AnyObject {
    func display(viewModel: LoginView.ViewModel)
    func display(hint: String)
}

final class CpfValidationViewController: UIViewController {
    private var interactor: CpfValidationInteracting
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
    
    init(interactor: CpfValidationInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CpfValidationViewController: CpfValidationDisplay {
    func display(viewModel: LoginView.ViewModel) {
        loginView.configureView(usingViewModel: viewModel)
        loginView.textField.delegate = self
        loginView.button.action { [weak self] in
            self?.interactor.validateCpf()
        }
    }
    
    func display(hint: String) {
        loginView.textField.showHint(true, text: hint)
    }
}

extension CpfValidationViewController: TextFieldDelegate {
    var keyBoardType: UIKeyboardType {
        .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let sanitizedText = updatedText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        interactor.cpfIsValid = sanitizedText.isValidCpf
        loginView.textField.showHint(false)
        let formattedText = sanitizedText.applyCpfMask()
        textField.text = formattedText
        return false
    }
}

