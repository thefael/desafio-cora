import CoraDesignSystem

protocol WelcomePresenting {
    var viewModel: WelcomeView.ViewModel { get }
    func presentLoginScreen()
}

final class WelcomePresenter: WelcomePresenting {
    var viewModel: WelcomeView.ViewModel = .init(
        backgroundColor: .accentPink,
        button: .init(
            type: .icon(.init(name: .arrowRight)),
            style: .secondary,
            text: "Quero fazer parte!"
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
