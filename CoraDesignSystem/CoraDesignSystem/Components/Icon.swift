import UIKit

final public class Icon: UIView {
    public typealias Size = Token.Size
    public typealias Color = Token.Color
    public typealias IconName = Token.IconName
    
    private let container: UIView = .init()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
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
    
    @discardableResult
    func setColor(_ color: Color) -> Self {
        imageView.tintColor = color.uiColor
        return self
    }
}

public extension Icon {
    struct ViewModel {
        let name: IconName
        var color: Color
        
        public init(name: IconName, color: Color = .undefined) {
            self.name = name
            self.color = color
        }
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
