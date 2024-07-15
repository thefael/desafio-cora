import Foundation

protocol ExtractInteracting {
    func loadData()
    func didTapCell(atIndexPath indexPath: IndexPath)
}

final class ExtractInteractor: ExtractInteracting {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting
    var list: ExtractList?
    
    init(service: ExtractServicing, presenter: ExtractPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func loadData() {
        Task { @MainActor in
            do {
                let list = try await service.getList()
                self.list = list
                presenter.present(list: list)
            } catch {
                print(error)
            }
        }
    }
    
    func didTapCell(atIndexPath indexPath: IndexPath) {
        guard let list, let item = list.results[safe: indexPath.section]?.items[safe: indexPath.row] else { return }
        presenter.presentDetail(itemId: item.id)
    }
}
