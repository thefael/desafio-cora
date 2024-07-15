import CoraDesignSystem
import UIKit

final class ExtractDetailView: UIView {
    typealias Size = Token.Size
    
    private let icon: Icon = .init()
    private let titleText: Text = .init()
        .style(.body1)
        .bold()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, titleText])
        stackView.axis = .horizontal
        stackView.spacing = Size.size02
        return stackView
    }()
    private let valueView = DetailedTextView()
    private let dateView = DetailedTextView()
    private let senderView = DetailedTextView()
    private let recipientView = DetailedTextView()
    private let descriptionView = DetailedTextView()
    
    private let scrollView: UIScrollView = .init()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleStack,
            valueView,
            dateView,
            senderView,
            recipientView,
            descriptionView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Size.size06
        return stackView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = Token.Color.white.uiColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(usingViewModel viewModel: ExtractDetailView.ViewModel) {
        titleText.text = viewModel.title
        icon.configure(usingViewModel: viewModel.icon)
        valueView.configure(usingViewModel: viewModel.value)
        dateView.configure(usingViewModel: viewModel.date)
        senderView.configure(usingViewModel: viewModel.sender)
        recipientView.configure(usingViewModel: viewModel.recipient)
        descriptionView.configure(usingViewModel: viewModel.description)
    }
}

private extension ExtractDetailView {
    func setupConstraints() {
        setupScrollViewConstraints()
        setupContentStackViewConstraints()
    }
    
    func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        contentStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Size.size12).isActive = true
        contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Size.size08).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Size.size20).isActive = true
    }
}

extension ExtractDetailView {
    struct ViewModel {
        let icon: Icon.ViewModel
        let title: String
        let value: DetailedTextView.ViewModel
        let date: DetailedTextView.ViewModel
        let sender: DetailedTextView.ViewModel
        let recipient: DetailedTextView.ViewModel
        let description: DetailedTextView.ViewModel
    }
}

extension ExtractDetailView {
    func makeStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Size.size01
        return stackView
    }
}
