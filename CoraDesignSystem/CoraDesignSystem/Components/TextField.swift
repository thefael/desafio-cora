import UIKit

public protocol TextFieldDelegate: AnyObject, UITextFieldDelegate {
    var keyBoardType: UIKeyboardType { get }
}

final public class TextField: UIView {
    private let textFieldTextStyle = Token.TextStyle.title3
    private let titleText = Text()
        .style(.title3)
        .bold()
    private lazy var textField: UITextField = {
        let textField = UITextField()
            .textStyle(textFieldTextStyle)
        textField.tintColor = Token.Color.darkGray.uiColor
        return textField
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleText,
            textField
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Token.Size.size08
        return stackView
    }()
    public weak var delegate: TextFieldDelegate? {
        didSet {
            self.textField.delegate = delegate
        }
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(usingViewModel viewModel: ViewModel) {
        titleText.text = viewModel.title
    }
    
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        textField.keyboardType = delegate?.keyBoardType ?? .default
        return textField.becomeFirstResponder()
    }
}

private extension TextField {
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        textField.heightAnchor.constraint(equalToConstant: textFieldTextStyle.lineHeight).isActive = true
        textField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
}

extension TextField {
    public struct ViewModel {
        let title: String
        
        public init(title: String) {
            self.title = title
        }
    }
}

extension UITextField {
    @discardableResult
    func textStyle(_ textStyle: Token.TextStyle) -> Self {
        font = UIFont(
            name: textStyle.fontFamily,
            size: textStyle.fontSize
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = textStyle.lineHeight
        paragraphStyle.maximumLineHeight = textStyle.lineHeight
        
        let attributedText = NSMutableAttributedString(string: text ?? "")
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        self.attributedText = attributedText
        return self
    }
}

final class Validation {
    public func validatePassword(password: String) -> Bool {
        let passRegEx = "^.{6,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
}
