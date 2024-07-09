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
    
    let loginButton = Button()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(usingViewModel viewModel: ViewModel) {
        backgroundColor = viewModel.backgroundColor.uiColor
        loginButton.configure(usingViewModel: viewModel.button)
    }
}

private extension WelcomeView {
    func setupConstraints() {
        setupBackgroundViewConstraints()
        setupImageConstraints()
        setupButtonConstraints()
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
    }
    
    func setupButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginButton)
        loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Size.size09).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.size06).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.size06).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: Size.size16).isActive = true
    }
}

extension WelcomeView {
    struct ViewModel {
        let backgroundColor: Color
        let button: Button.ViewModel
    }
}
