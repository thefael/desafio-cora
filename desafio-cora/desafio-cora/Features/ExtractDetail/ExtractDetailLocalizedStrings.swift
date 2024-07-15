import Foundation

enum ExtractDetailLocalizedStrings: String {
    case agency
    case account
    case valueTitle
    case dateTitle
    case senderTitle
    case recipientTitle
    case descriptionTitle
}


extension ExtractDetailLocalizedStrings: Localizable {
    var bundle: Bundle { Bundle.main }
    var stringName: String { rawValue }
    var stringFileName: String? { "Localizable" }
}
