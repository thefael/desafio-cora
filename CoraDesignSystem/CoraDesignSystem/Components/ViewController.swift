import UIKit

public final class ViewController: UIViewController {
    typealias Size = Token.Size
    let button: Button = .init()
        .enable(false)
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setupConstraints()
        button.configure(
            usingViewModel: .init(
                type: .icon(
                    .init(name: .arrowRight, color: .white)),
                text: "Cora teste",
                colorScheme: .init(
                    background: .accentPink,
                    text: .white
                )
            )
        )
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.heightAnchor.constraint(equalToConstant: Size.size16).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Size.size04).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
