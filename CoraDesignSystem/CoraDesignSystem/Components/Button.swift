import UIKit

final public class Button: UIButton {
    public typealias Size = Token.Size
    public typealias Color = Token.Color
    
    private let textLabel: UILabel = .init()
    private var icon: Icon = .init()
    private var action: (() -> Void)?
    
    private var viewModel: Button.ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(usingViewModel viewModel: Button.ViewModel) {
        self.viewModel = viewModel
        configureBaseComponent(viewModel)
        configureStantardTypeIfNeeded(viewModel)
        configureIconTypeIfNeeded(viewModel)
        configureDisabledState()
    }
    
    @discardableResult
    public func enable(_ isEnabled: Bool = true) -> Self {
        self.isEnabled = isEnabled

        if isEnabled {
            guard let viewModel else { return self }
            backgroundColor = viewModel.colorScheme.background.uiColor
        }
        else {
            backgroundColor = Color.mediumLightGray.uiColor
        }
        return self
    }
    
    @discardableResult
    public func action(_ action: @escaping () -> Void) -> Self {
        self.action = action
        addTarget(self, action: #selector(executeAction), for: .touchUpInside)
        return self
    }
}

private extension Button {
    func configureBaseComponent(_ viewModel: Button.ViewModel) {
        layer.cornerRadius = Size.size04
        textLabel.text = viewModel.text
        textLabel.textColor = viewModel.colorScheme.text.uiColor
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        configureBackgroundColor(viewModel.colorScheme.background.uiColor)
    }
    
    func configureBackgroundColor(_ color: UIColor) {
        if isEnabled {
            backgroundColor = color
        } else {
            backgroundColor = Color.lightGray.uiColor
        }
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
    
    func configureDisabledState() {
        setTitleColor(Color.white.uiColor, for: .disabled)
    }
    
    @objc
    func executeAction() {
        action?()
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
        
        public init(type: Type, text: String, colorScheme: ColorScheme) {
            self.type = type
            self.text = text
            self.colorScheme = colorScheme
        }
    }
    
    struct ColorScheme {
        public let background: Color
        public let text: Color
        
        public init(background: Color, text: Color) {
            self.background = background
            self.text = text
        }
    }
    
    enum `Type` {
        case standard
        case icon(_ viewModel: Icon.ViewModel)
    }
}
