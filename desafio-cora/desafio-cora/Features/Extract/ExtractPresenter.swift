import CoraDesignSystem
import UIKit

protocol ExtractPresenting {
    func present(list: ExtractList)
}

final class ExtractPresenter: ExtractPresenting {
    weak var display: ExtractDisplay?
    
    func present(list: ExtractList) {
        let items: [ExtractCell.ViewModel] = list.allItems.map { _ in
            .init(
                icon: .init(name: .arrowDown),
                currency: "R$",
                value: "",
                label: "",
                name: "",
                time: "",
                colorScheme: .init(
                    currency: .accentBlue,
                    value: .accentBlue,
                    label: .accentBlue
                )
            )
        }
        display?.display(items: items)
    }
}
