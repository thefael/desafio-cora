import UIKit

final class GenericTableViewDataSource<T: TableViewSection, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    var sections: [T] = []
    var configureCell: ((T.S, Cell) -> Void)?
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? Cell else {
            return UITableViewCell()
        }
        configureCell?(item, cell)
        return cell
    }
}

protocol TableViewSection<S> {
    associatedtype S
    var title: String { get }
    var items: [S] { get }
}
