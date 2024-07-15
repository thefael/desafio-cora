import Foundation

protocol ExtractDetailInteracting {
    func loadData()
}

final class ExtractDetailInteractor: ExtractDetailInteracting {
    private let service: ExtractDetailServicing
    private let presenter: ExtractDetailPresenting
    private let id: String
    private let entry: ExtractList.Section.Item.Entry
    
    init(
        service: ExtractDetailServicing,
        presenter: ExtractDetailPresenting,
        id: String,
        entry: ExtractList.Section.Item.Entry
    ) {
        self.service = service
        self.presenter = presenter
        self.id = id
        self.entry = entry
    }
    
    func loadData() {
        Task { @MainActor in
            do {
                let detail = try await service.getDetail(usingId: id)
                presenter.present(detail: detail, entry: entry)
            } catch {
                print(error)
            }
        }
    }
}
