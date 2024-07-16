import Foundation
import CoraNetwork

protocol ExtractDetailInteracting {
    func loadData()
    func didTapAlertButton(type: AlertType)
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
            } catch let error as ApiError {
                switch error {
                case .unauthorized:
                    presenter.presentAlert(
                        type: .logout,
                        errorTitle: ExtractDetailLocalizedStrings.unauthorizedErrorTitle.localized,
                        errorMessage: ExtractDetailLocalizedStrings.unauthorizedErrorMessage.localized,
                        buttonCaption: ExtractDetailLocalizedStrings.buttonCaption.localized
                    )
                default:
                    presenter.presentAlert(
                        type: .dismiss,
                        errorTitle: ExtractDetailLocalizedStrings.genericErrorTitle.localized,
                        errorMessage: ExtractDetailLocalizedStrings.genericErrorMessage.localized,
                        buttonCaption: ExtractDetailLocalizedStrings.back.localized
                    )
                }
            }
        }
    }
    
    func didTapAlertButton(type: AlertType) {
        switch type {
        case .logout:
            presenter.presentRoot()
        case .dismiss:
            presenter.dismiss()
        }
    }
}

enum AlertType {
    case logout
    case dismiss
}
