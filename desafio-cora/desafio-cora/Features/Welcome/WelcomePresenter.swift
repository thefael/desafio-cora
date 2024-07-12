import CoraDesignSystem

protocol WelcomePresenting {
    var viewModel: WelcomeView.ViewModel { get }
    func presentLoginScreen()
}

final class WelcomePresenter: WelcomePresenting {
    var viewModel: WelcomeView.ViewModel = .init(
        backgroundColor: .accentPink,
        titleText: "Conta Digital PJ",
        subtitleText: "Poderosamente Simples",
        descriptionText: "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.",
        textColor: .white,
        button: .init(
            type: .icon(.init(name: .arrowRight)),
            style: .primary,
            text: "Entrar"
        )
    )
    private let coordinator: WelcomeCoordinating
    
    init(coordinator: WelcomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func presentLoginScreen() {
        print("present login")
    }
}
