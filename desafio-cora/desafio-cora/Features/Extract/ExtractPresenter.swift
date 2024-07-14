import CoraDesignSystem
import UIKit

protocol ExtractPresenting {
    func present(list: ExtractList)
}

final class ExtractPresenter: ExtractPresenting {
    weak var display: ExtractDisplay?
    
    func present(list: ExtractList) {
        let sections: [ExtractView.ViewModel.Section] = list.results.map {
            .init(
                title: makeFormattedDate(
                    $0.date,
                    fromFormat: .dayMonthYear,
                    toFormat: .weekExtenseDisplay
                ),
                items: $0.items.map {
                    .init(
                        icon: makeIconViewModel($0.entry),
                        currency: Currency.brl.rawValue,
                        value: makeCurrencyValue($0.amount),
                        label: $0.label,
                        name: $0.name,
                        time: makeFormattedDate(
                            $0.dateEvent,
                            fromFormat: .full,
                            toFormat: .hourDisplay
                        ),
                        colorScheme: makeColorScheme($0.entry)
                    )
                }
            )
        }
        display?.display(sections: sections)
    }
}

private extension ExtractPresenter {
    
    func makeColorScheme(_ type: ExtractList.Section.Item.Entry) -> ExtractCell.ViewModel.ColorScheme {
        switch type {
        case .credit:
            return .init(currency: .accentBlue, value: .accentBlue, label: .accentBlue)
        case .debit:
            return .init(currency: .darkGray, value: .darkGray, label: .darkGray)
        }
    }
    
    func makeCurrencyValue(_ value: Int) -> String {
        let float = CGFloat(value / 100)
        let formatted = String(format: "%.2f", float)
        return formatted.replacingOccurrences(of: ".", with: ",")
    }
    
    func makeIconViewModel(_ type: ExtractList.Section.Item.Entry) -> Icon.ViewModel {
        switch type {
        case .credit:
            return .init(name: .arrowDown, color: .darkGray)
        case .debit:
            return .init(name: .arrowUp, color: .darkGray)
        }
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
}

enum DateFormat: String {
    case full = "yyyy-MM-dd'T'HH:mm:ssZ"
    case hourDisplay = "HH:mm"
    case weekExtenseDisplay = "EEEE, d 'de' MMMM"
    case dayMonthYear = "yyyy-MM-dd"
}

enum Currency: String {
    case brl = "R$"
}
