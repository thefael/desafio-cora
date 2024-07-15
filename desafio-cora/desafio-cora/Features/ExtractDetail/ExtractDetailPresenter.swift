import CoraDesignSystem
import UIKit

protocol ExtractDetailPresenting {
    func present(detail: ExtractDetail)
}

final class ExtractDetailPresenter: ExtractDetailPresenting {
    weak var display: ExtractDetailDisplay?
    
    func present(detail: ExtractDetail) {
        let viewModel: ExtractDetailView.ViewModel = .init(
            icon: .init(name: .arrowRight, color: .darkGray),
            title: detail.label,
            value: .init(
                title: ExtractDetailLocalizedStrings.valueTitle.localized,
                value: Currency.brl.rawValue + " " + makeCurrencyValue(detail.amount)
            ),
            date: .init(
                title: ExtractDetailLocalizedStrings.dateTitle.localized,
                value: makeFormattedDate(
                    detail.dateEvent,
                    fromFormat: .full,
                    toFormat: .weekDayDMY
                )
            ),
            sender: .init(
                title: ExtractDetailLocalizedStrings.senderTitle.localized,
                value: detail.sender.name,
                description: makeDescription(detail)
            ),
            recipient: .init(
                title: ExtractDetailLocalizedStrings.recipientTitle.localized,
                value: detail.recipient.name,
                description: makeDescription(detail)
            ),
            description: .init(
                title: ExtractDetailLocalizedStrings.descriptionTitle.localized,
                description: detail.description
            )
        )
        display?.display(viewModel: viewModel)
    }
    
    func makeCurrencyValue(_ value: Int) -> String {
        let float = CGFloat(value / 100)
        let formatted = String(format: "%.2f", float)
        return formatted.replacingOccurrences(of: ".", with: ",")
    }
    
    func makeFormattedDate(_ string: String, fromFormat: DateFormat, toFormat: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "pt_BR")
        formatter.dateFormat = fromFormat.rawValue
        guard let date = formatter.date(from: string) else { return "–––" }
        
        formatter.dateFormat = toFormat.rawValue
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    
    func makeDocument(_ accountDetail: ExtractDetail.AccountDetail) -> String {
        switch accountDetail.documentType {
        case .cpf:
            return accountDetail.documentType.rawValue + " " + accountDetail.documentNumber.applyMask(.cpf)
        case .cnpj:
            return accountDetail.documentType.rawValue + " " + accountDetail.documentNumber.applyMask(.cnpj)
        }
    }
    
    func makeAgencyAndAccount(_ accountDetail: ExtractDetail.AccountDetail) -> String {
        let x = accountDetail
        let agency = String(format: ExtractDetailLocalizedStrings.agency.localized, x.agencyNumber, x.agencyNumberDigit)
        let account = String(format: ExtractDetailLocalizedStrings.account.localized, x.accountNumber, x.accountNumberDigit)
        return  agency + " - " + account
    }
    
    func makeDescription(_ detail: ExtractDetail) -> String {
        let document = makeDocument(detail.sender)
        let bankName = detail.sender.bankName
        let agencyAndAccount = makeAgencyAndAccount(detail.sender)
        let strings = [bankName, agencyAndAccount]
        return strings.reduce(document) { "\($0)\n\($1)" }
    }
}
