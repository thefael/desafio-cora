import CoraDesignSystem
import UIKit

final class ExtractView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExtractCell.self, forCellReuseIdentifier: "reuseIdentifier")
        return tableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupTableViewContstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
private extension ExtractView {
    func setupTableViewContstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension ExtractView {
    struct ViewModel {
        let list: [ExtractCell.ViewModel]
    }
}
