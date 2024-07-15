import CoraDesignSystem
import UIKit

final class DetailedTextView: UIView {
    typealias Size = Token.Size
    private let titleText: Text = .init()
        .style(.body2)
        .setColor(.darkGray)
    
    private let valueText: Text = .init()
        .style(.body1)
        .bold()
        .setColor(.darkGray)
    
    private let descriptionText: Text = .init()
        .style(.body2)
        .numberOfLines(0)
        .setColor(.mediumDarkGray)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Size.size01
        return stackView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailedTextView {
    func configure(usingViewModel viewModel: ViewModel) {
        stackView.addArrangedSubview(titleText)
        titleText.text = viewModel.title
        
        if let value = viewModel.value {
            stackView.addArrangedSubview(valueText)
            valueText.text = value
        }
        
        if let description = viewModel.description {
            stackView.addArrangedSubview(descriptionText)
            descriptionText.text = description
        }
    }
}

private extension DetailedTextView {
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension DetailedTextView {
    struct ViewModel {
        let title: String
        let value: String?
        let description: String?
        
        init(title: String, value: String? = nil, description: String? = nil) {
            self.title = title
            self.value = value
            self.description = description
        }
    }
}
