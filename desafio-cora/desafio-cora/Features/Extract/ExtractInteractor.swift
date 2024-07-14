import Foundation

protocol ExtractInteracting {
    func loadData()
}

final class ExtractInteractor: ExtractInteracting {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting
    
    init(service: ExtractServicing, presenter: ExtractPresenter) {
        self.service = service
        self.presenter = presenter
    }
    
    func loadData() {
        Task { @MainActor in
            do {
                let list = try await service.getList()
                presenter.present(list: list)
            } catch {
                print(error)
            }
        }
    }
}
