import Foundation

enum LoginLocalizedStrings: String {
    case cpfHintText
    case cpfTextFieldTitle
    case passwordTextFieldTitle
    case loginButtonText
    case loginErrorTitle
    case unauthorizedErrorMessage
    case genericErrorMessage
}


extension LoginLocalizedStrings: Localizable {
    var bundle: Bundle { Bundle.main }
    var stringName: String { rawValue }
    var stringFileName: String? { "Localizable" }
}
