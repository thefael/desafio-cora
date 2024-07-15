import CoraDesignSystem

protocol WelcomePresenting {
    var viewModel: WelcomeView.ViewModel { get }
    func presentLoginScreen()
}

final class WelcomePresenter: WelcomePresenting {
    var viewModel: WelcomeView.ViewModel = .init(
        backgroundColor: .accentPink,
        titleText: WelcomeLocalizedStrings.title.localized,
        subtitleText: WelcomeLocalizedStrings.subtitle.localized,
        descriptionText: WelcomeLocalizedStrings.description.localized,
        textColor: .white,
        button: .init(
            type: .icon(.init(name: .arrowRight)),
            style: .primary,
            text: WelcomeLocalizedStrings.welcomeButtonText.localized
        )
    )
    private let coordinator: WelcomeCoordinating
    
    init(coordinator: WelcomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func presentLoginScreen() {
        coordinator.open()
    }
}
