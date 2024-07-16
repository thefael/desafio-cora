import Foundation

enum ExtractLocalizedStrings: String {
    case unauthorizedErrorTitle
    case unauthorizedErrorMessage
    case genericErrorTitle
    case genericErrorMessage
    case buttonCaption
}


extension ExtractLocalizedStrings: Localizable {
    var bundle: Bundle { Bundle.main }
    var stringName: String { rawValue }
    var stringFileName: String? { "Localizable" }
}
