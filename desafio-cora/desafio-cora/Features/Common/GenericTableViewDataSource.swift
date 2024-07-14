import UIKit

final class GenericTableViewDataSource<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    var items = [T]()
    var configureCell: ((T, Cell) -> Void)?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? Cell else {
            return UITableViewCell()
        }
        configureCell?(item, cell)
        return cell
    }
}
