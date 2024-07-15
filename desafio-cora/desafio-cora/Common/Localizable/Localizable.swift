import Foundation

protocol Localizable {
    var bundle: Bundle { get }
    var stringFileName: String? { get }
    var localized: String { get }
    var stringName: String { get }
}

extension Localizable {
    var localized: String {
        NSLocalizedString(
            stringName,
            tableName: stringFileName,
            bundle: bundle,
            comment: String()
        )
    }
    
    var stringFileName: String? { nil }
}
