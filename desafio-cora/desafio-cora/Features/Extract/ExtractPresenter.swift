import CoraDesignSystem
import UIKit

protocol ExtractPresenting {
    func present(list: ExtractList)
}

final class ExtractPresenter: ExtractPresenting {
    weak var display: ExtractDisplay?
    
    func present(list: ExtractList) {
        let items: [ExtractCell.ViewModel] = [1, 2, 3, 4].map { _ in
            .init(
                icon: .init(name: .arrowDown),
                currency: "R$",
                value: "30,00",
                label: "Transferência recebida",
                name: "Lucas Melo",
                time: "17:32",
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
