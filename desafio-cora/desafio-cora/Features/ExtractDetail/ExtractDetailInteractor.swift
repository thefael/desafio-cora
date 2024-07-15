import Foundation

protocol ExtractDetailInteracting {
    func loadData()
}

final class ExtractDetailInteractor: ExtractDetailInteracting {
    private let service: ExtractDetailServicing
    private let presenter: ExtractDetailPresenting
    private let id: String
    
    init(service: ExtractDetailServicing, presenter: ExtractDetailPresenting, id: String) {
        self.service = service
        self.presenter = presenter
        self.id = id
    }
    
    func loadData() {
        Task { @MainActor in
            do {
                let detail = try await service.getDetail(usingId: id)
                presenter.present(detail: detail)
            } catch {
                print(error)
            }
        }
    }
}
