import UIKit

final public class Button: UIButton {
    public typealias Size = Token.Size
    public typealias Color = Token.Color
    
    private let textLabel: UILabel = .init()
    private var icon: Icon = .init()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Button {
    func configure(usingViewModel viewModel: Button.ViewModel) {
        configureBaseComponent(viewModel)
        configureStantardTypeIfNeeded(viewModel)
        configureIconTypeIfNeeded(viewModel)
    }
    
    func configureBaseComponent(_ viewModel: Button.ViewModel) {
        textLabel.text = viewModel.text
        textLabel.textColor = viewModel.colorScheme.text.uiColor
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        backgroundColor = viewModel.colorScheme.background.uiColor
    }
    
    func configureStantardTypeIfNeeded(_ viewModel: Button.ViewModel) {
        if case .standard = viewModel.type {
            icon.removeFromSuperview()
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
    
    func configureIconTypeIfNeeded(_ viewModel: Button.ViewModel) {
        if case let .icon(iconViewModel) = viewModel.type {
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
            
            icon.configure(usingViewModel: iconViewModel)
            icon.heightAnchor.constraint(equalToConstant: Size.size06).isActive = true
            icon.widthAnchor.constraint(equalToConstant: Size.size06).isActive = true
            icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
        }
    }
}

private extension Button {
    func setupConstraints() {
        setupTextLabel()
        setupIcon()
    }
    
    func setupTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
    }
    
    func setupIcon() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
    }
}


public extension Button {
    struct ViewModel {
        public let type: `Type`
        public let text: String
        public let colorScheme: ColorScheme
    }
    
    struct ColorScheme {
        public let background: Color
        public let text: Color
    }
    
    enum `Type` {
        case standard
        case icon(_ viewModel: Icon.ViewModel)
    }
}
