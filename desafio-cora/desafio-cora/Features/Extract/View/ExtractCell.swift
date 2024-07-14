import CoraDesignSystem
import UIKit

final class ExtractCell: UITableViewCell {
    typealias Size = Token.Size
    typealias Color = Token.Color
    
    private let icon: Icon = .init()
        .setColor(.darkGray)
    
    private let currencyText: Text = .init()
        .style(.body1)
    
    private let valueText: Text = .init()
        .style(.body1)
        .bold()
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            currencyText,
            valueText
        ])
        stackView.axis = .horizontal
        stackView.spacing = Size.size01
        return stackView
    }()
    
    private let labelText: Text = .init()
        .style(.body2)
    
    private let nameText: Text = .init()
        .style(.body2)
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            valueStackView,
            labelText,
            nameText
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let timeText: Text = .init()
        .style(.caption)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(usingViewModel viewModel: ViewModel) {
        icon.configure(usingViewModel: viewModel.icon)
        currencyText.text = viewModel.currency
        valueText.text = viewModel.value
        labelText.text = viewModel.label
        nameText.text = viewModel.name
        timeText.text = viewModel.time
        
        currencyText.setColor(viewModel.colorScheme.currency)
        valueText.setColor(viewModel.colorScheme.value)
        labelText.setColor(viewModel.colorScheme.label)
    }
}

private extension ExtractCell {
    func setupConstraints() {
        setupIconConstraints()
        setupDetailsStackViewConstraints()
        setupTimeTextContraints()
    }
    
    func setupIconConstraints() {
        contentView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.size03).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Size.size06).isActive = true
        icon.widthAnchor.constraint(equalToConstant: Size.size06).isActive = true
        icon.heightAnchor.constraint(equalToConstant: Size.size06).isActive = true
    }
    
    func setupDetailsStackViewConstraints() {
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsStackView)
        detailsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.size03).isActive = true
        detailsStackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Size.size04).isActive = true
        contentView.bottomAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: Size.size03).isActive = true
    }
    
    func setupTimeTextContraints() {
        timeText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeText)
        timeText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Size.size06).isActive = true
        timeText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}

extension ExtractCell {
    struct ViewModel {
        let icon: Icon.ViewModel
        let currency: String
        let value: String
        let label: String
        let name: String
        let time: String
        let colorScheme: ColorScheme
        
        struct ColorScheme {
            let currency: Color
            let value: Color
            let label: Color
        }
    }
}
