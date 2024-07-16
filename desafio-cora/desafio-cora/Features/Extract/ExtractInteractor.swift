import Foundation
import CoraNetwork

protocol ExtractInteracting {
    func loadData()
    func didTapCell(atIndexPath indexPath: IndexPath)
    func didTapAlertButton()
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
            } catch let error as ApiError {
                switch error {
                case .unauthorized:
                    presenter.presentAlert(
                        errorTitle: ExtractLocalizedStrings.unauthorizedErrorTitle.localized,
                        errorMessage: ExtractLocalizedStrings.unauthorizedErrorMessage.localized,
                        buttonCaption: ExtractLocalizedStrings.buttonCaption.localized
                    )
                default:
                    presenter.presentAlert(
                        errorTitle: ExtractLocalizedStrings.genericErrorTitle.localized,
                        errorMessage:
                            ExtractLocalizedStrings.genericErrorMessage.localized,
                        buttonCaption: ExtractLocalizedStrings.buttonCaption.localized
                    )
                }
            }
        }
    }
    
    func didTapCell(atIndexPath indexPath: IndexPath) {
        guard let list, let item = list.results[safe: indexPath.section]?.items[safe: indexPath.row] else { return }
        presenter.presentDetail(itemId: item.id, entry: item.entry)
    }
    
    func didTapAlertButton() {
        presenter.presentRoot()
    }
}
