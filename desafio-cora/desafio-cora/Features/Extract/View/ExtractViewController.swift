import CoraDesignSystem
import UIKit

protocol ExtractDisplay: AnyObject {
//    func display(items: [ExtractCell.ViewModel])
    func display(sections: [ExtractView.ViewModel.Section])
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

extension ExtractViewController: ExtractDisplay {
    func display(sections: [ExtractView.ViewModel.Section]) {
        DispatchQueue.main.async {
            self.tableViewDataSource.sections = sections
            self.extractView.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
