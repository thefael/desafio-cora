import Foundation

enum WelcomeLocalizedStrings: String {
    case title
    case subtitle
    case description
    case welcomeButtonText
}


extension WelcomeLocalizedStrings: Localizable {
    var bundle: Bundle { Bundle.main }
    var stringName: String { rawValue }
    var stringFileName: String? { "Localizable" }
}
