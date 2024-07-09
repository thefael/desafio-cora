import UIKit

final public class Icon: UIView {
    typealias Size = Token.Size
    typealias Color = Token.Color
    typealias IconName = Token.IconName
    
    private let container: UIView = .init()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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
        let image = UIImage(named: viewModel.name.rawValue)?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = viewModel.color.uiColor
    }
}

public extension Icon {
    struct ViewModel {
        let name: IconName
        let color: Color
    }
}

private extension Icon {
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -Size.size01).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -Size.size01).isActive = true
    }
}
