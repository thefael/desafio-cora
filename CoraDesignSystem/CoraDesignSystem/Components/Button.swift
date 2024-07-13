import UIKit

final public class Button: UIButton {
    public typealias Size = Token.Size
    public typealias Color = Token.Color
    
    private let text = Text()
        .bold()
    private var icon: Icon = .init()
    private var action: (() -> Void)?
    private var buttonSize: ButtonSize = .medium
    
    private var viewModel: Button.ViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(usingViewModel viewModel: Button.ViewModel) {
        self.viewModel = viewModel
        let colorScheme = makeColorScheme(viewModel.style)
        configureBaseComponent(viewModel, colorScheme: colorScheme)
        configureStantardTypeIfNeeded(viewModel)
        configureIconTypeIfNeeded(viewModel, colorScheme: colorScheme)
        configureButtonSize()
        configureDisabledState()
    }
    
    @discardableResult
    public func enable(_ isEnabled: Bool = true) -> Self {
        self.isEnabled = isEnabled

        if isEnabled {
            guard let viewModel else { return self }
            backgroundColor = (viewModel.style == .primary) ? Color.accentPink.uiColor : Color.white.uiColor
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
    
    @discardableResult
    public func size(_ size: ButtonSize) -> Self {
        self.buttonSize = size
        return self
    }
}

private extension Button {
    func configureBaseComponent(_ viewModel: Button.ViewModel, colorScheme: Button.ColorScheme) {
        layer.cornerRadius = Size.size04
        text.text = viewModel.text
        text.textColor = colorScheme.text.uiColor
        text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        configureBackgroundColor(colorScheme.background.uiColor)
    }
    
    func makeColorScheme(_ style: Button.Style) -> Button.ColorScheme {
        switch style {
        case .primary:
            return .init(background: .white, text: .accentPink, icon: .accentPink)
        case .secondary:
            return .init(background: .accentPink, text: .white, icon: .white)
        }
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
            text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
    }
    
    func configureIconTypeIfNeeded(_ viewModel: Button.ViewModel, colorScheme: Button.ColorScheme) {
        if case var .icon(iconViewModel) = viewModel.type {
            if case .undefined = iconViewModel.color {
                iconViewModel.color = colorScheme.icon
            }
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
            
            icon.configure(usingViewModel: iconViewModel)
            setupIconConstraints()
        }
    }
    
    func configureButtonSize() {
        var buttonHeight: CGFloat = Size.size16
        switch buttonSize {
        case .medium:
            buttonHeight = Size.size16
            text.style(.body1)
        case .small:
            buttonHeight = Size.size12
            text.style(.body2)
        }
        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
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
    func addSubviews() {
        addSubview(text)
        addSubview(icon)
    }
    
    func setupIconConstraints() {
        icon.heightAnchor.constraint(equalToConstant: Size.size06).isActive = true
        icon.widthAnchor.constraint(equalToConstant: Size.size06).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
    }
}


public extension Button {
    struct ViewModel {
        public let type: `Type`
        public let style: Style
        public let text: String
        
        public init(type: Type, style: Style, text: String) {
            self.type = type
            self.style = style
            self.text = text
        }
    }
    
    enum `Type` {
        case standard
        case icon(_ viewModel: Icon.ViewModel)
    }
    
    enum Style {
        case primary
        case secondary
    }
    
    struct ColorScheme {
        public let background: Color
        public let text: Color
        public let icon: Color
    }
    
    enum ButtonSize {
        case medium
        case small
    }
}
