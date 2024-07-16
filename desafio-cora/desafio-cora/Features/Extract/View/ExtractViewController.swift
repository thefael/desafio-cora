import CoraDesignSystem
import UIKit

protocol ExtractDisplay: AnyObject {
    func display(sections: [ExtractView.ViewModel.Section])
    func displayAlert(title: String, message: String, buttonCaption: String)
}

final class ExtractViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    private let extractView = ExtractView()
    private let tableViewDataSource: GenericTableViewDataSource<ExtractView.ViewModel.Section, ExtractCell> = {
        let dataSource = GenericTableViewDataSource<ExtractView.ViewModel.Section, ExtractCell>()
        dataSource.configureCell = { viewModel, cell in
            cell.configure(usingViewModel: viewModel)
        }
        return dataSource
    }()
    private let interactor: ExtractInteracting
    
    init(interactor: ExtractInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        configureRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        extractView.tableView.dataSource = tableViewDataSource
        extractView.tableView.delegate = self
        view = extractView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        extractView.tableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh() {
        interactor.loadData()
    }
}

extension ExtractViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapCell(atIndexPath: indexPath)
    }
}

extension ExtractViewController: ExtractDisplay {
    func display(sections: [ExtractView.ViewModel.Section]) {
        DispatchQueue.main.async {
            self.tableViewDataSource.sections = sections
            self.extractView.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func displayAlert(title: String, message: String, buttonCaption: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action: UIAlertAction = .init(title: buttonCaption, style: .default) { [weak self] _ in
            self?.interactor.didTapAlertButton()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
