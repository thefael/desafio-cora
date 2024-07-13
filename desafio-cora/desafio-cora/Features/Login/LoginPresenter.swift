import Foundation

protocol LoginPresenting {
    var viewModel: LoginView.ViewModel { get }
    
}

final class LoginPresenter: LoginPresenting {
    let viewModel: LoginView.ViewModel = .init(
        textField: .init(title: "Qual seu CPF?"),
        button: .init(
            type: .icon(.init(name: .arrowRight)),
            style: .secondary,
            text: "Próximo"
        )
    )
}
