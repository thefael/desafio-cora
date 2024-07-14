import CoraDesignSystem
import UIKit

protocol ExtractDisplay: AnyObject {
    func display(items: [ExtractCell.ViewModel])
}

final class ExtractViewController: UIViewController {
    private let extractView = ExtractView()
    private let tableViewDataSource = GenericTableViewDataSource<ExtractCell.ViewModel, ExtractCell>()
    private let interactor: ExtractInteracting
    
    init(interactor: ExtractInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
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
}

extension ExtractViewController: ExtractDisplay {
    func display(items: [ExtractCell.ViewModel]) {
        print(items)
        DispatchQueue.main.async {
            self.tableViewDataSource.items = items
            self.extractView.tableView.reloadData()
        }
    }
}
