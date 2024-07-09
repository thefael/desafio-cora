import CoraDesignSystem

protocol WelcomePresenting {
    var viewModel: WelcomeView.ViewModel { get }
    func presentLoginScreen()
}

final class WelcomePresenter: WelcomePresenting {
    var viewModel: WelcomeView.ViewModel = .init(
        backgroundColor: .accentPink,
        button: .init(
            type: .icon(.init(name: .arrowRight, color: .accentPink)),
            text: "Entrar",
            colorScheme: .init(background: .white, text: .accentPink)
        )
    )
    
    func presentLoginScreen() {
        print("present login")
    }
}
