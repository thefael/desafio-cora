import UIKit

public extension Token {
    enum Color {
        case accentPink
        case white
        case accentBlue
        
        case lightGray
        case mediumLightGray
        case mediumDarkGray
        case darkGray
        
        var uiColor: UIColor {
            switch self {
            case .accentPink:
                return UIColor(hex: "f53e6d")
            case .white:
                return UIColor(hex: "ffffff")
            case .accentBlue:
                return UIColor(hex: "3294da")
            case .lightGray:
                return UIColor(hex: "6c7075")
            case .mediumLightGray:
                return UIColor(hex: "3b3b3b")
            case .mediumDarkGray:
                return UIColor(hex: "f0f4f8")
            case .darkGray:
                return UIColor(hex: "dfe4e8")
            }
        }
    }
}
