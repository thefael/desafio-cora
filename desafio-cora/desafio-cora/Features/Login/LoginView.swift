import UIKit
import CoraDesignSystem

final class LoginView: UIView {
    typealias Size = Token.Size
    typealias Color = Token.Color
    lazy var textField = TextField()
    lazy var button = Button()
        .size(.small)
    
    private lazy var buttonBottomConstraint: NSLayoutConstraint = button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Size.size09)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = Color.white.uiColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(usingViewModel viewModel: ViewModel) {
        textField.configure(usingViewModel: viewModel.textField)
        button.configure(usingViewModel: viewModel.button)
    }
    
    func focusOntextField() {
        textField.becomeFirstResponder()
        buttonBottomConstraint.constant = -((UIScreen.main.bounds.height / 3) + Size.size09)
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.button.setNeedsLayout()
                self.button.layoutIfNeeded()
            },
            completion: nil
        )
    }
}

private extension LoginView {
    func setupConstraints() {
        setupTextFieldConstraints()
        setupButtonConstraints()
    }
    
    func setupTextFieldConstraints() {
        addSubview(textField)
        textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Size.size15).isActive = true
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
    }
    
    func setupButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        buttonBottomConstraint.isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
    }
}
extension LoginView {
    struct ViewModel {
        let textField: TextField.ViewModel
        let button: Button.ViewModel
        
        static let cpf: Self = .init(
            textField: .init(
                title: LoginLocalizedStrings.cpfTextFieldTitle.localized
            ),
            button: .init(
                type: .icon(.init(name: .arrowRight)),
                style: .secondary,
                text: LoginLocalizedStrings.loginButtonText.localized
            )
        )
        
        static let password: Self = .init(
            textField: .init(title: LoginLocalizedStrings.passwordTextFieldTitle.localized),
            button: .init(
                type: .icon(.init(name: .arrowRight)),
                style: .secondary,
                text: LoginLocalizedStrings.loginButtonText.localized
            )
        )
    }
}
