import UIKit
import CoraDesignSystem

final class WelcomeView: UIView {
    typealias Size = Token.Size
    typealias Color = Token.Color
    
    private let backgroundView: UIView = .init()
    private let backgroundImageView: UIImageView = {
        let image = UIImage(named: "welcome")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    private let titleText: Text = .init()
        .style(.header1)
        .bold()
    
    private let subtitleText: Text = .init()
        .style(.header1)
    
    private let descriptionText: Text = .init()
        .style(.body1)
        .numberOfLines(0)
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleText,
            subtitleText,
            descriptionText
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.setCustomSpacing(Size.size04, after: subtitleText)
        return stackView
    }()
    
    let loginButton = Button()
        .size(.medium)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(usingViewModel viewModel: ViewModel) {
        backgroundColor = viewModel.backgroundColor.uiColor
        configureTexts(viewModel)
        loginButton.configure(usingViewModel: viewModel.button)
    }
}

private extension WelcomeView {
    func configureTexts(_ viewModel: ViewModel) {
        titleText.text = viewModel.titleText
        subtitleText.text = viewModel.subtitleText
        descriptionText.text = viewModel.descriptionText
        
        titleText.textColor = viewModel.textColor.uiColor
        subtitleText.textColor = viewModel.textColor.uiColor
        descriptionText.textColor = viewModel.textColor.uiColor
    }
}

private extension WelcomeView {
    func setupConstraints() {
        setupBackgroundViewConstraints()
        setupImageConstraints()
        setupButtonConstraints()
        setupTextStackViewConstraints()
    }
    
    func setupBackgroundViewConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    
    func setupImageConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func setupTextStackViewConstraints() {
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textStackView)
        textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
        textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
        textStackView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Size.size15).isActive = true
        textStackView.bottomAnchor.constraint(greaterThanOrEqualTo: loginButton.topAnchor, constant: -Size.size08).isActive = true
    }
    
    func setupButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginButton)
        loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Size.size09).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
    }
}

extension WelcomeView {
    struct ViewModel {
        let backgroundColor: Color
        let titleText: String
        let subtitleText: String
        let descriptionText: String
        let textColor: Color
        let button: Button.ViewModel
    }
}
