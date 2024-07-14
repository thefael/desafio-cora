import CoraDesignSystem
import UIKit

protocol ExtractPresenting {
    func present(list: ExtractList)
}

final class ExtractPresenter: ExtractPresenting {
    weak var display: ExtractDisplay?
    
    func present(list: ExtractList) {
        let items: [ExtractCell.ViewModel] = list.allItems.map {
            .init(
                icon: makeIconViewModel($0.entry),
                currency: "R$",
                value: makeCurrencyValue($0.amount),
                label: $0.description,
                name: $0.name,
                time: makeFormattedDate($0.dateEvent),
                colorScheme: makeColorScheme($0.entry)
            )
        }
        display?.display(items: items)
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
    
    func makeFormattedDate(_ string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: string) else { return "00:00" }
        
        formatter.dateFormat = "HH:mm"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
