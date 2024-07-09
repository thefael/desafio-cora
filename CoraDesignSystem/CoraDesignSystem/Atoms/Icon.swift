import UIKit

final public class Icon: UIView {
    typealias Size = Token.Size
    typealias Color = Token.Color
    
    private let imageView: UIImageView = .init()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Icon {
    func configure(usingViewModel viewModel: Icon.ViewModel) {
        let image = UIImage(systemName: viewModel.name)
        imageView.image = image
        imageView.tintColor = viewModel.color.uiColor
    }
}

public extension Icon {
    struct ViewModel {
        let name: String
        let color: Color
    }
}

private extension Icon {
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
